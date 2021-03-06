resources
readNativeResourceFrom: byteStream
	| img aStream |
	aStream := byteStream.
	img := [ImageReadWriter formFromStream: aStream] on: Error do:[:ex| nil].
	img ifNil:[^nil].
	(img isColorForm and:[self isColorForm]) ifTrue:[
		| cc |
		cc := img colors.
		img colors: nil.
		img displayOn: self.
		img colors: cc.
	] ifFalse:[
		img displayOn: self.
	].
	img := nil.