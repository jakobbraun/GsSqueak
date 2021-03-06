become
restoreHeadersAfterForwardBecome: copyHashFlag 
	"Forward become leaves us with no original oops in the 
	mutated object list, 
	so we must enumerate the (four-word) forwarding blocks 
	where we have stored backpointers."
	"This loop start is copied from fwdTableInit:"
	| oop1 fwdBlock oop2 hdr1 hdr2 |
	fwdBlock := endOfMemory + self baseHeaderSize + 7 bitAnd: self wordMask - 7.
	self flag: #Dan.  "See flag comment in fwdTableInit: (dtl)"
	fwdBlock := fwdBlock + (self bytesPerWord * 4).
	"fwdBlockGet: did a pre-increment"
	[self oop: fwdBlock isLessThanOrEqualTo: fwdTableNext
	"fwdTableNext points to the last active block"]
		whileTrue: [oop1 := self longAt: fwdBlock + (self bytesPerWord * 2).
			"Backpointer to mutated object."
			oop2 := self longAt: fwdBlock.
			self restoreHeaderOf: oop1.
			copyHashFlag
				ifTrue: ["Change the hash of the new oop (oop2) to be that of the old (oop1) 
					so mutated objects in hash structures will be 
					happy after the change."
					hdr1 := self longAt: oop1.
					hdr2 := self longAt: oop2.
					self longAt: oop2 put: ((hdr2 bitAnd: self allButHashBits) bitOr: (hdr1 bitAnd: HashBits))].
			fwdBlock := fwdBlock + (self bytesPerWord * 4)]