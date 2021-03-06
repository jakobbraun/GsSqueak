accessing
performAction
	"Inform the model that this button has been pressed. Sent by the controller when this button is pressed. If the button's actionSelector takes any arguments, they are obtained dynamically by sending the argumentSelector to the argumentsProvider"

	askBeforeChanging ifTrue: [model okToChange ifFalse: [^ self]].
	actionSelector ifNotNil:
		[actionSelector numArgs = 0
			ifTrue:
				[model perform: actionSelector]
			ifFalse:
				[argumentsProvider ifNotNil:
					[arguments := argumentsProvider perform: argumentsSelector].
					model perform: actionSelector withArguments: arguments]]