monitoring
refresh
	
	self parent ifNil: [^ self].
	[model explorerContents detect: [:wrapper | wrapper itemName = self itemName]
		ifFound: [:wrapper | ^ self object: wrapper object ]
		ifNone: [^ self object: nil]] 
			on: Error 
			do: [ :ex | self object: nil ]