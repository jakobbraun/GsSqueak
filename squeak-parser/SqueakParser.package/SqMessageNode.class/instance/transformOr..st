macro transformations
transformOr: encoder 
	(self transformBoolean: encoder)
		ifTrue: [arguments := Array
						with: ((SqBlockNode withJust: NodeTrue)
								noteOptimizedIn: self)
						with: ((arguments at: 1)
								noteOptimizedIn: self).
			^ true]
		ifFalse: [^ false]