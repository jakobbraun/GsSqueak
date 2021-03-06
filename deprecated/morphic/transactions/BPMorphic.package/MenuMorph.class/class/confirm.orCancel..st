utilities
confirm: queryString orCancel: cancelBlock 
	"Put up a yes/no/cancel menu with caption aString. Answer true if the
	response is yes, false if no. If cancel is chosen, evaluate cancelBlock.
	This is a modal question--the user must respond yes or no."
	"MenuMorph confirm: 'Reboot universe' orCancel:[^'Nevermind']"
	| _gsSqueakTemp_choice |
	_gsSqueakTemp_choice := self
				chooseFrom: {'Yes' translated. 'No' translated. 'Cancel' translated}
				lines: #()
				title: queryString.
	_gsSqueakTemp_choice = 1
		ifTrue: [^ true].
	_gsSqueakTemp_choice = 2
		ifTrue: [^ false].
	^ cancelBlock value