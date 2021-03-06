inner loop
alphaSourceBlendBits16
	"This version assumes 
	combinationRule = 34
	sourcePixSize = 32
	destPixSize = 16
	sourceForm ~= destForm.
	"
	| _gsSqueakTemp_srcIndex _gsSqueakTemp_dstIndex _gsSqueakTemp_sourceWord _gsSqueakTemp_srcAlpha _gsSqueakTemp_destWord _gsSqueakTemp_deltaX _gsSqueakTemp_deltaY _gsSqueakTemp_srcY _gsSqueakTemp_dstY _gsSqueakTemp_dstMask _gsSqueakTemp_srcShift _gsSqueakTemp_ditherBase _gsSqueakTemp_ditherIndex _gsSqueakTemp_ditherThreshold |
	<inline: false>
	"This particular method should be optimized in itself"
	_gsSqueakTemp_deltaY := bbH + 1.
	"So we can pre-decrement"
	_gsSqueakTemp_srcY := sy.
	_gsSqueakTemp_dstY := dy.
	_gsSqueakTemp_srcShift := (dx bitAnd: 1)
				* 16.
	destMSB
		ifTrue: [_gsSqueakTemp_srcShift := 16 - _gsSqueakTemp_srcShift].
	mask1 := 65535 << (16 - _gsSqueakTemp_srcShift).
	"This is the outer loop"
	[(_gsSqueakTemp_deltaY := _gsSqueakTemp_deltaY - 1) ~= 0]
		whileTrue: [_gsSqueakTemp_srcIndex := sourceBits + (_gsSqueakTemp_srcY * sourcePitch) + (sx * 4).
			_gsSqueakTemp_dstIndex := destBits + (_gsSqueakTemp_dstY * destPitch) + (dx // 2 * 4).
			_gsSqueakTemp_ditherBase := (_gsSqueakTemp_dstY bitAnd: 3)
						* 4.
			_gsSqueakTemp_ditherIndex := (sx bitAnd: 3)
						- 1.
			"For pre-increment"
			_gsSqueakTemp_deltaX := bbW + 1.
			"So we can pre-decrement"
			_gsSqueakTemp_dstMask := mask1.
			_gsSqueakTemp_dstMask = 65535
				ifTrue: [_gsSqueakTemp_srcShift := 16]
				ifFalse: [_gsSqueakTemp_srcShift := 0].
			"This is the inner loop"
			[(_gsSqueakTemp_deltaX := _gsSqueakTemp_deltaX - 1) ~= 0]
				whileTrue: [_gsSqueakTemp_ditherThreshold := ditherMatrix4x4 at: _gsSqueakTemp_ditherBase + (_gsSqueakTemp_ditherIndex := _gsSqueakTemp_ditherIndex + 1 bitAnd: 3).
					_gsSqueakTemp_sourceWord := self srcLongAt: _gsSqueakTemp_srcIndex.
					_gsSqueakTemp_srcAlpha := _gsSqueakTemp_sourceWord >> 24.
					_gsSqueakTemp_srcAlpha = 255
						ifTrue: ["Dither from 32 to 16 bit"
							_gsSqueakTemp_sourceWord := self dither32To16: _gsSqueakTemp_sourceWord threshold: _gsSqueakTemp_ditherThreshold.
							_gsSqueakTemp_sourceWord = 0
								ifTrue: [_gsSqueakTemp_sourceWord := 1 << _gsSqueakTemp_srcShift]
								ifFalse: [_gsSqueakTemp_sourceWord := _gsSqueakTemp_sourceWord << _gsSqueakTemp_srcShift].
							"Store masked value"
							self
								dstLongAt: _gsSqueakTemp_dstIndex
								put: _gsSqueakTemp_sourceWord
								mask: _gsSqueakTemp_dstMask]
						ifFalse: ["srcAlpha ~= 255"
							_gsSqueakTemp_srcAlpha = 0
								ifFalse: ["0 < srcAlpha < 255"
									"If we have to mix colors then just copy
									a single word"
									_gsSqueakTemp_destWord := self dstLongAt: _gsSqueakTemp_dstIndex.
									_gsSqueakTemp_destWord := _gsSqueakTemp_destWord bitAnd: _gsSqueakTemp_dstMask bitInvert32.
									_gsSqueakTemp_destWord := _gsSqueakTemp_destWord >> _gsSqueakTemp_srcShift.
									"Expand from 16 to 32 bit by adding
									zero bits"
									_gsSqueakTemp_destWord := (((_gsSqueakTemp_destWord bitAnd: 31744)
												bitShift: 9)
												bitOr: ((_gsSqueakTemp_destWord bitAnd: 992)
														bitShift: 6))
												bitOr: (((_gsSqueakTemp_destWord bitAnd: 31)
														bitShift: 3)
														bitOr: 4278190080).
									"Mix colors"
									_gsSqueakTemp_sourceWord := self alphaBlendScaled: _gsSqueakTemp_sourceWord with: _gsSqueakTemp_destWord.
									"And dither"
									_gsSqueakTemp_sourceWord := self dither32To16: _gsSqueakTemp_sourceWord threshold: _gsSqueakTemp_ditherThreshold.
									_gsSqueakTemp_sourceWord = 0
										ifTrue: [_gsSqueakTemp_sourceWord := 1 << _gsSqueakTemp_srcShift]
										ifFalse: [_gsSqueakTemp_sourceWord := _gsSqueakTemp_sourceWord << _gsSqueakTemp_srcShift].
									"Store back"
									self
										dstLongAt: _gsSqueakTemp_dstIndex
										put: _gsSqueakTemp_sourceWord
										mask: _gsSqueakTemp_dstMask]].
					_gsSqueakTemp_srcIndex := _gsSqueakTemp_srcIndex + 4.
					destMSB
						ifTrue: [_gsSqueakTemp_srcShift = 0
								ifTrue: [_gsSqueakTemp_dstIndex := _gsSqueakTemp_dstIndex + 4]]
						ifFalse: [_gsSqueakTemp_srcShift = 0
								ifFalse: [_gsSqueakTemp_dstIndex := _gsSqueakTemp_dstIndex + 4]].
					_gsSqueakTemp_srcShift := _gsSqueakTemp_srcShift bitXor: 16.
					"Toggle between 0 and 16"
					_gsSqueakTemp_dstMask := _gsSqueakTemp_dstMask bitInvert32].
			_gsSqueakTemp_srcY := _gsSqueakTemp_srcY + 1.
			_gsSqueakTemp_dstY := _gsSqueakTemp_dstY + 1]