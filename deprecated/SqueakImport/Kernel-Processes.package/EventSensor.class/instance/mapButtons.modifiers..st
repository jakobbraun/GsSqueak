private-I/O
mapButtons: buttons modifiers: modifiers
	"Map the buttons to yellow or blue based on the given modifiers.
	If only the red button is pressed, then map
		Ctrl-RedButton -> BlueButton.
		Cmd-RedButton -> YellowButton.
	"
	(buttons = RedButtonBit)
		ifFalse:[^buttons].
	(modifiers allMask: CtrlKeyBit) 
		ifTrue:[^BlueButtonBit].
	(modifiers allMask: CommandKeyBit) 
		ifTrue:[^YellowButtonBit].
	^buttons