submorphs-accessing
morphsInFrontOverlapping: aRectangle 
	"Return all top-level morphs in front of someMorph that overlap with
	the given rectangle."
	| morphList |
	morphList := WriteStream on: Array new.
	self
		morphsInFrontOf: nil
		overlapping: aRectangle
		do: [:m | morphList nextPut: m].
	^ morphList contents