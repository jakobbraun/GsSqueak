preferences
globalCommandKeysEnabled: aBoolean 
	GlobalCommandKeysEnabled = aBoolean
		ifTrue: [^ self].
	GlobalCommandKeysEnabled := aBoolean.
	SystemWindow
		allSubInstancesDo: [:ea | aBoolean
				ifTrue: [ea addKeyboardShortcuts]
				ifFalse: [ea removeKeyboardShortcuts]].
	PasteUpMorph
		allSubInstancesDo: [:ea | aBoolean
				ifTrue: [ea addKeyboardShortcuts]
				ifFalse: [ea removeKeyboardShortcuts]]