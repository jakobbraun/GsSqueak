*SqClasses-*SqClasses-*SqClasses-system attributes
endianness
	^EndianCache ifNil: [EndianCache := self calcEndianness]
