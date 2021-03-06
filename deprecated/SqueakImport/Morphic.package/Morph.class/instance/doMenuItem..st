menus
doMenuItem: menuString
	| aMenu anItem aNominalEvent aHand |
	aMenu := self buildHandleMenu: (aHand := self currentHand).
	aMenu allMorphsDo: [:m | m step].  "Get wordings current"
	anItem := aMenu itemWithWording: menuString.
	anItem ifNil:
		[^ self player scriptingError: 'Menu item not found: ', menuString].
	aNominalEvent :=  MouseButtonEvent new
		setType: #mouseDown
		position: anItem bounds center
		which: 4 "red"
		buttons: 4 "red"
		hand: aHand
		stamp: nil.
	anItem invokeWithEvent: aNominalEvent