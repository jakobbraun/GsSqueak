get the page
httpRequest: method url: urlString headers: hdrs content: contentOrNil response: responseBlock

	"Sends an HTTP request to the server. Returns a MIMEDocument if successful,
	a string indicating the error otherwise. If a response block is provided, the
	response is fed into into so that the sender can see all the headers.
	The url string is assumed to be properly escaped by the sender."

	| index serverAndPort server port rawUrl stream resp code headers 
	  contentLength contentType content |

	(urlString beginsWith: 'http://') ifFalse:[self error: 'Not a http url'].

	"Extract server, port, and url"
	index := urlString indexOf: $/ startingAt: 8 ifAbsent:[urlString size+1]. "past http://"
	serverAndPort := urlString copyFrom: 8 to: index-1.
	server := serverAndPort copyUpTo: $:.
	port := ((serverAndPort copyAfter: $:) ifEmpty:['80']) asNumber.

	"Prepare the request URI"
	rawUrl := urlString copyFrom: index to: urlString size.
	(rawUrl beginsWith: '/') ifFalse:[rawUrl := '/', rawUrl].

	"Check for proxy"
	(self shouldUseProxy: server) ifTrue:[
		self httpProxyServer ifNotEmpty:[
			rawUrl := 'http://', serverAndPort, rawUrl. "per RFC 2616"
			server := self httpProxyServer.
			port := self httpProxyPort.
		].
	].

	"Fire off the request"
	stream := SocketStream openConnectionToHostNamed: server port: port.
	stream nextPutAll: method; space; nextPutAll: rawUrl; space; nextPutAll: 'HTTP/1.0'; crlf.
	stream nextPutAll: 'Host: ', serverAndPort; crlf.
	stream nextPutAll: 'Connection: close'; crlf.
	stream nextPutAll: 'User-Agent: ', self userAgentString; crlf.
	stream nextPutAll: 'Accept-Encoding: gzip'; crlf.
	stream nextPutAll: hdrs.
	stream crlf.

	contentOrNil ifNotNil:[
		| contentStream |
		"Upload request content"
		contentStream := contentOrNil readStream.
		[contentStream atEnd] whileFalse:[
			(HTTPProgress new) total: contentOrNil size; 
				amount: contentStream position; signal: 'Uploading...'.
			stream nextPutAll: (contentStream next: 4096).
			stream flush.
		].
	].

	stream flush.

	"Read the response"
	resp := stream upToAll: String crlfcrlf.
	"Extract the response code"
	code := ((resp copyUpTo: String cr) findTokens: ' ') second asNumber.
	"And the response headers"
	headers := Dictionary new.
	resp lines allButFirstDo: [ :nextLine |
		headers at: (nextLine copyUpTo: $:) asLowercase 
			put: (nextLine copyAfter: $:) withBlanksTrimmed ].

     	(code between: 301 and: 303)
		ifTrue:[
			 headers at: 'location' ifPresent: [:location |
				stream close.
				^ self httpRequest: method url: location headers: hdrs content: contentOrNil response: responseBlock]].


	"Read response content"
	contentLength := headers at: 'content-length' ifAbsent:[nil].
	contentType := headers at: 'content-type' ifAbsent:['application/octet-stream'].

	"Fixme - Provide HTTProgress"
	contentLength 
		ifNil: [ content := stream upToEnd ]
		ifNotNil: [
			contentLength := contentLength asInteger.
			content := String new: contentLength.
			index := 1.
			[ index <= contentLength ] whileTrue: [
				| bytesRead |
				bytesRead := stream readInto: content startingAt: index count: ((contentLength - index + 1) min: 8192).
				index := index + bytesRead.
				HTTPProgress new
						total: contentLength; 
						amount: index;
						signal: 'Downloading...' ] ].

	responseBlock ifNotNil:[responseBlock value: resp].

	(headers at: 'content-encoding' ifAbsent: [ nil ]) = 'gzip' ifTrue: [
		content := (GZipReadStream on: content) upToEnd ].

	^(code between: 200 and: 299) 
		ifTrue:[MIMEDocument contentType: contentType 
				content: content url: urlString]
		ifFalse:[resp asString, content].
