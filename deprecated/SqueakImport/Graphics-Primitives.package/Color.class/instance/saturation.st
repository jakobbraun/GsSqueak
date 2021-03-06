accessing
saturation
	"Return the saturation of this color, a value between 0.0 and 1.0."

	| r g b max min |
	r := self privateRed.
	g := self privateGreen.
	b := self privateBlue. 

	max := min := r.
	g > max ifTrue: [max := g].
	b > max ifTrue: [max := b].
	g < min ifTrue: [min := g].
	b < min ifTrue: [min := b].

	max = 0
		ifTrue: [ ^ 0.0 ]
		ifFalse: [ ^ (max - min) asFloat / max asFloat ].
