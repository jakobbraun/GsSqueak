events-processing
filterEvent: aKeyboardEvent for: anObject
	"Provide keyboard shortcuts."
	
	| index itemToSelect |

	aKeyboardEvent controlKeyPressed
		ifFalse: [^ aKeyboardEvent].

	(aKeyboardEvent isKeyDown or: [aKeyboardEvent isKeystroke]) "We also need #keyDown for Windows platforms because CTRL+X does not trigger key strokes there..."
		ifFalse: [^ aKeyboardEvent].
			
	"Search field."
	aKeyboardEvent keyCharacter = $0
		ifTrue: [
			self searchBarMorph ifNotNil: [ :morph |
				morph model activate: aKeyboardEvent in: morph ].
			^ aKeyboardEvent ignore "hit!"].
	
	"Select menu items."
	(aKeyboardEvent keyValue 
		between: $1 asciiValue 
		and: $9 asciiValue)
			ifFalse: [^ aKeyboardEvent].	
			
	index := aKeyboardEvent keyValue - $1 asciiValue + 1.
	itemToSelect := (self submorphs select: [ :each | 
		each isKindOf: DockingBarItemMorph ]) 
			at: index 
			ifAbsent: [^ aKeyboardEvent].
			
	self activate: aKeyboardEvent.
	self 
		selectItem: itemToSelect
		event: aKeyboardEvent.

	^ aKeyboardEvent ignore "hit!"