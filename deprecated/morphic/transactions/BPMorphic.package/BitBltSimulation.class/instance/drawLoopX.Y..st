interpreter interface
drawLoopX: xDelta Y: yDelta 
	"This is the primitive implementation of the line-drawing loop.
	See the comments in BitBlt>>drawLoopX:Y:"
	| _gsSqueakTemp_dx1 _gsSqueakTemp_dy1 _gsSqueakTemp_px _gsSqueakTemp_py _gsSqueakTemp_P _gsSqueakTemp_affL _gsSqueakTemp_affR _gsSqueakTemp_affT _gsSqueakTemp_affB |
	xDelta > 0
		ifTrue: [_gsSqueakTemp_dx1 := 1]
		ifFalse: [xDelta = 0
				ifTrue: [_gsSqueakTemp_dx1 := 0]
				ifFalse: [_gsSqueakTemp_dx1 := -1]].
	yDelta > 0
		ifTrue: [_gsSqueakTemp_dy1 := 1]
		ifFalse: [yDelta = 0
				ifTrue: [_gsSqueakTemp_dy1 := 0]
				ifFalse: [_gsSqueakTemp_dy1 := -1]].
	_gsSqueakTemp_px := yDelta abs.
	_gsSqueakTemp_py := xDelta abs.
	_gsSqueakTemp_affL := _gsSqueakTemp_affT := 9999.
	"init null rectangle"
	_gsSqueakTemp_affR := _gsSqueakTemp_affB := -9999.
	_gsSqueakTemp_py > _gsSqueakTemp_px
		ifTrue: ["more horizontal"
			_gsSqueakTemp_P := _gsSqueakTemp_py // 2.
			1
				to: _gsSqueakTemp_py
				do: [:i | 
					destX := destX + _gsSqueakTemp_dx1.
					(_gsSqueakTemp_P := _gsSqueakTemp_P - _gsSqueakTemp_px) < 0
						ifTrue: [destY := destY + _gsSqueakTemp_dy1.
							_gsSqueakTemp_P := _gsSqueakTemp_P + _gsSqueakTemp_py].
					i < _gsSqueakTemp_py
						ifTrue: [self copyBits.
							interpreterProxy failed
								ifTrue: [^ nil"bail out now on failure -- avoid storing
									x,y "].
							(affectedL < affectedR
									and: [affectedT < affectedB])
								ifTrue: ["Affected rectangle grows along the
									line "
									_gsSqueakTemp_affL := _gsSqueakTemp_affL min: affectedL.
									_gsSqueakTemp_affR := _gsSqueakTemp_affR max: affectedR.
									_gsSqueakTemp_affT := _gsSqueakTemp_affT min: affectedT.
									_gsSqueakTemp_affB := _gsSqueakTemp_affB max: affectedB.
									_gsSqueakTemp_affR - _gsSqueakTemp_affL * (_gsSqueakTemp_affB - _gsSqueakTemp_affT) > 4000
										ifTrue: ["If affected rectangle gets
											large, update it in chunks"
											affectedL := _gsSqueakTemp_affL.
											affectedR := _gsSqueakTemp_affR.
											affectedT := _gsSqueakTemp_affT.
											affectedB := _gsSqueakTemp_affB.
											self showDisplayBits.
											_gsSqueakTemp_affL := _gsSqueakTemp_affT := 9999.
											"init null rectangle"
											_gsSqueakTemp_affR := _gsSqueakTemp_affB := -9999]]]]]
		ifFalse: ["more vertical"
			_gsSqueakTemp_P := _gsSqueakTemp_px // 2.
			1
				to: _gsSqueakTemp_px
				do: [:i | 
					destY := destY + _gsSqueakTemp_dy1.
					(_gsSqueakTemp_P := _gsSqueakTemp_P - _gsSqueakTemp_py) < 0
						ifTrue: [destX := destX + _gsSqueakTemp_dx1.
							_gsSqueakTemp_P := _gsSqueakTemp_P + _gsSqueakTemp_px].
					i < _gsSqueakTemp_px
						ifTrue: [self copyBits.
							interpreterProxy failed
								ifTrue: [^ nil"bail out now on failure -- avoid storing
									x,y "].
							(affectedL < affectedR
									and: [affectedT < affectedB])
								ifTrue: ["Affected rectangle grows along the
									line "
									_gsSqueakTemp_affL := _gsSqueakTemp_affL min: affectedL.
									_gsSqueakTemp_affR := _gsSqueakTemp_affR max: affectedR.
									_gsSqueakTemp_affT := _gsSqueakTemp_affT min: affectedT.
									_gsSqueakTemp_affB := _gsSqueakTemp_affB max: affectedB.
									_gsSqueakTemp_affR - _gsSqueakTemp_affL * (_gsSqueakTemp_affB - _gsSqueakTemp_affT) > 4000
										ifTrue: ["If affected rectangle gets
											large, update it in chunks"
											affectedL := _gsSqueakTemp_affL.
											affectedR := _gsSqueakTemp_affR.
											affectedT := _gsSqueakTemp_affT.
											affectedB := _gsSqueakTemp_affB.
											self showDisplayBits.
											_gsSqueakTemp_affL := _gsSqueakTemp_affT := 9999.
											"init null rectangle"
											_gsSqueakTemp_affR := _gsSqueakTemp_affB := -9999]]]]].
	"Remaining affected rect"
	affectedL := _gsSqueakTemp_affL.
	affectedR := _gsSqueakTemp_affR.
	affectedT := _gsSqueakTemp_affT.
	affectedB := _gsSqueakTemp_affB.
	"store destX, Y back"
	interpreterProxy
		storeInteger: BBDestXIndex
		ofObject: bitBltOop
		withValue: destX.
	interpreterProxy
		storeInteger: BBDestYIndex
		ofObject: bitBltOop
		withValue: destY