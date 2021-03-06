examples
showHSVPalettes
	"Shows a palette of hues, varying the saturation and brightness for
	each one. Best results are with depths 16 and 32."
	"Color showHSVPalettes"
	| _gsSqueakTemp_left _gsSqueakTemp_top _gsSqueakTemp_c |
	_gsSqueakTemp_left := _gsSqueakTemp_top := 0.
	0
		to: 179
		by: 15
		do: [:h | 0
				to: 10
				do: [:s | 
					_gsSqueakTemp_left := h * 4 + (s * 4).
					0
						to: 10
						do: [:v | 
							_gsSqueakTemp_c := Color
										h: h
										s: s asFloat / 10.0
										v: v asFloat / 10.0.
							_gsSqueakTemp_top := v * 4.
							Display
								fill: (_gsSqueakTemp_left @ _gsSqueakTemp_top extent: 4 @ 4)
								fillColor: _gsSqueakTemp_c.
							_gsSqueakTemp_c := Color
										h: h + 180
										s: s asFloat / 10.0
										v: v asFloat / 10.0.
							_gsSqueakTemp_top := v * 4 + 50.
							Display
								fill: (_gsSqueakTemp_left @ _gsSqueakTemp_top extent: 4 @ 4)
								fillColor: _gsSqueakTemp_c]]]