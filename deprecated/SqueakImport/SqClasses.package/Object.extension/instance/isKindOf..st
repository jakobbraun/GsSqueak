*SqClasses-class membership
isKindOf: aClass 
	"Answer whether the class, aClass, is a superclass or class of the receiver."
	^ self class == aClass or: [ self class inheritsFrom: aClass ]
