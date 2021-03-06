query
allMethodsSelect: aBlock 
	"Answer a sorted collection of each method that, when used as the block  
	argument to aBlock, gives a true result."
	
	| result |
	result := OrderedCollection new.
	self allSelectorsAndMethodsDo: [ :behavior :selector :method |
		(aBlock value: method) ifTrue: [
			result add: (MethodReference class: behavior selector: selector) ] ].
	^result sort