initialization
initializeKeyboardShortcuts
	"Install an event capture filter to add shortcuts for global operations like opening a tool."
	
	PasteUpMorph globalCommandKeysEnabled
		ifTrue: [self addKeyboardShortcuts].