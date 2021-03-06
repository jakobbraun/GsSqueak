meta-actions
embedInto: evt
	"Embed the receiver into some other morph"
	|  target morphs |
	morphs := self potentialEmbeddingTargets.
	target := UIManager default 
		chooseFrom: (morphs collect:[:m| m knownName ifNil:[m class name asString]])
		values: self potentialEmbeddingTargets
		title: ('Place ', self externalName, ' in...').
	target ifNil:[^self].
	target addMorphFrontFromWorldPosition: self