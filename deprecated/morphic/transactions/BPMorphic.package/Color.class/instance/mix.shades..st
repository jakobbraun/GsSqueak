groups of shades
mix: color2 shades: thisMany 
	"Return an array of thisMany colors from self to color2. Very useful for
	displaying color based on a variable in your program. "
	"Color showColors: (Color red mix: Color green shades: 12)"
	| _gsSqueakTemp_redInc _gsSqueakTemp_greenInc _gsSqueakTemp_blueInc _gsSqueakTemp_out _gsSqueakTemp_rr _gsSqueakTemp_gg _gsSqueakTemp_bb |
	thisMany = 1
		ifTrue: [^ Array with: color2].
	_gsSqueakTemp_redInc := color2 red - self red / (thisMany - 1).
	_gsSqueakTemp_greenInc := color2 green - self green / (thisMany - 1).
	_gsSqueakTemp_blueInc := color2 blue - self blue / (thisMany - 1).
	_gsSqueakTemp_rr := self red.
	_gsSqueakTemp_gg := self green.
	_gsSqueakTemp_bb := self blue.
	_gsSqueakTemp_out := (1 to: thisMany)
				collect: [:num | 
					| c |
					c := Color
								r: _gsSqueakTemp_rr
								g: _gsSqueakTemp_gg
								b: _gsSqueakTemp_bb.
					_gsSqueakTemp_rr := _gsSqueakTemp_rr + _gsSqueakTemp_redInc.
					_gsSqueakTemp_gg := _gsSqueakTemp_gg + _gsSqueakTemp_greenInc.
					_gsSqueakTemp_bb := _gsSqueakTemp_bb + _gsSqueakTemp_blueInc.
					c].
	_gsSqueakTemp_out at: _gsSqueakTemp_out size put: color2.
	"hide roundoff errors"
	^ _gsSqueakTemp_out