*SqClasses-system primitives
asOop
	"This method is for compatibility only.
	In Smalltalk, this used to return an integer unique to each object.
	In Squeak, OOPs are internal to the VM.  Accessing an OOP would be useless anyway since it changes when the object is moved during garbage collection."

	^self identityHash
