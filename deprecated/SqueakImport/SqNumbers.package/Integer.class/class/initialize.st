class initialization
initialize
	SmallInteger superclass: self.
	LargeInteger superclass: self.
	self initializeLowBitPerByteTable;
    initializeBitCountPerByteTable

