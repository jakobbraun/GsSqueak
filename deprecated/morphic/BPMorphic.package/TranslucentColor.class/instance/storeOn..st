printing
storeOn: aStream 
	self isTransparent
		ifTrue: [^ aStream nextPutAll: '(Color transparent)'].
	super storeOn: aStream.
	aStream skip: -1;
		 nextPutAll: ' alpha: ';
		 print: self alpha maxDecimalPlaces: 3;
		 nextPutAll: ')'