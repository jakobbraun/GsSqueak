slot getters/setters
bookEmbodied
	"Answer the book embodied by the receiver's costume; usually this is
	directly the receiver's costume, but in case it is not, we look up the
	owner chain for one. This allows page-number messages to be sent to
	a *page* of the stack, as Alan is wont to do, and have them still find
	their way to the right place"
	| _gsSqueakTemp_aMorph |
	^ ((_gsSqueakTemp_aMorph := self costume renderedMorph) isKindOf: BookMorph)
		ifTrue: [_gsSqueakTemp_aMorph]
		ifFalse: [_gsSqueakTemp_aMorph ownerThatIsA: BookMorph]