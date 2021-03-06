examples
showHuesInteractively
	"Shows a palette of hues at a (saturation, brightness) point
	determined by the mouse position. Click the mouse button to exit and
	return the selected (saturation, brightness) point."
	"Color showHuesInteractively"
	| _gsSqueakTemp_p _gsSqueakTemp_s _gsSqueakTemp_v |
	[Sensor anyButtonPressed]
		whileFalse: [_gsSqueakTemp_p := Sensor cursorPoint.
			_gsSqueakTemp_s := _gsSqueakTemp_p x asFloat / 300.0.
			_gsSqueakTemp_v := _gsSqueakTemp_p y asFloat / 300.0.
			self
				showColors: (self
						wheel: 12
						saturation: _gsSqueakTemp_s
						brightness: _gsSqueakTemp_v)].
	^ (_gsSqueakTemp_s min: 1.0)
		@ (_gsSqueakTemp_v min: 1.0)