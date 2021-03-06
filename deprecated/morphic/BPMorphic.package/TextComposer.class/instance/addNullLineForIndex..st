as yet unclassified
addNullLineForIndex: index 
	"This awful bit is to ensure that if we have scanned all the text and the
	last character is a CR that there is a null line at the end of lines.
	Sometimes this was not happening which caused anomalous
	selections when selecting all the text. This is implemented as a
	post-composition fixup because I couldn't figure out where to put it in
	the main logic."
	| _gsSqueakTemp_oldLastLine _gsSqueakTemp_r |
	_gsSqueakTemp_oldLastLine := lines last.
	_gsSqueakTemp_oldLastLine last - _gsSqueakTemp_oldLastLine first >= 0
		ifFalse: [^ self].
	_gsSqueakTemp_oldLastLine last = (index - 1)
		ifFalse: [^ self].
	_gsSqueakTemp_r := _gsSqueakTemp_oldLastLine left @ _gsSqueakTemp_oldLastLine bottom extent: 0 @ (_gsSqueakTemp_oldLastLine bottom - _gsSqueakTemp_oldLastLine top).
	"Even though we may be below the bottom of the container,
	it is still necessary to compose the last line for consistency..."
	self addNullLineWithIndex: index andRectangle: _gsSqueakTemp_r