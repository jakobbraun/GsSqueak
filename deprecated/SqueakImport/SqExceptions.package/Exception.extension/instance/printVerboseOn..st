*SqExceptions-printing
printVerboseOn: aStream 
	aStream
		nextPutAll: 'vvvvvvvvvvvvvvvvvv ' , self description , ' vvvvvvvvvvvvvvvvvv' ;
		cr ;
		nextPutAll: 'The time is ', DateAndTime now asString ;
		cr.
	"Allow applications to optionally print extra details without overriding a base package."
	self printDetailsOn: aStream.
	aStream
		nextPutAll: self _env stackReport ;
		cr ;
		nextPutAll: '^^^^^^^^^^^^^^^^^^ ' , self description , ' ^^^^^^^^^^^^^^^^^^' ;
		cr ;
		flush
