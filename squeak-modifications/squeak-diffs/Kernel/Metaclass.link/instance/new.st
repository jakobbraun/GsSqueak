instance creation
new
	"The receiver can only have one instance. Create it or complain that
	one already exists."

	destClass class ~~ self
		ifTrue: [^destClass := self basicNew]
		ifFalse: [self error: 'A Metaclass should only have one instance!']
