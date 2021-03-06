combination rules
rgbComponentAlpha32
	"This version assumes 
	combinationRule = 41
	sourcePixSize = destPixSize = 32
	sourceForm ~= destForm.
	Note: The inner loop has been optimized for dealing
	with the special case of aR = aG = aB = 0 
	"
	| _gsSqueakTemp_srcIndex _gsSqueakTemp_dstIndex _gsSqueakTemp_sourceWord _gsSqueakTemp_srcAlpha _gsSqueakTemp_destWord _gsSqueakTemp_deltaX _gsSqueakTemp_deltaY _gsSqueakTemp_srcY _gsSqueakTemp_dstY |
	<inline: false>
	<var: #sourceWord declareC: 'register int sourceWord'>
	<var: #deltaX declareC: 'register int deltaX'>
	<var: #srcIndex declareC: 'register int srcIndex'>
	<var: #dstIndex declareC: 'register int dstIndex'>
	"This particular method should be optimized in itself"
	"Give the compile a couple of hints"
	"The following should be declared as pointers so the compiler will
	notice that they're used for accessing memory locations 
	(good to know on an Intel architecture) but then the increments
	would be different between ST code and C code so must hope the
	compiler notices what happens (MS Visual C does)"
	_gsSqueakTemp_deltaY := bbH + 1.
	"So we can pre-decrement"
	_gsSqueakTemp_srcY := sy.
	_gsSqueakTemp_dstY := dy.
	"This is the outer loop"
	[(_gsSqueakTemp_deltaY := _gsSqueakTemp_deltaY - 1) ~= 0]
		whileTrue: [_gsSqueakTemp_srcIndex := sourceBits + (_gsSqueakTemp_srcY * sourcePitch) + (sx * 4).
			_gsSqueakTemp_dstIndex := destBits + (_gsSqueakTemp_dstY * destPitch) + (dx * 4).
			_gsSqueakTemp_deltaX := bbW + 1.
			"So we can pre-decrement"
			"This is the inner loop"
			[(_gsSqueakTemp_deltaX := _gsSqueakTemp_deltaX - 1) ~= 0]
				whileTrue: [_gsSqueakTemp_sourceWord := self srcLongAt: _gsSqueakTemp_srcIndex.
					_gsSqueakTemp_srcAlpha := _gsSqueakTemp_sourceWord bitAnd: 16777215.
					_gsSqueakTemp_srcAlpha = 0
						ifTrue: [_gsSqueakTemp_srcIndex := _gsSqueakTemp_srcIndex + 4.
							_gsSqueakTemp_dstIndex := _gsSqueakTemp_dstIndex + 4.
							"Now skip as many words as possible,"
							[(_gsSqueakTemp_deltaX := _gsSqueakTemp_deltaX - 1) ~= 0
								and: [((_gsSqueakTemp_sourceWord := self srcLongAt: _gsSqueakTemp_srcIndex) bitAnd: 16777215)
										= 0]]
								whileTrue: [_gsSqueakTemp_srcIndex := _gsSqueakTemp_srcIndex + 4.
									_gsSqueakTemp_dstIndex := _gsSqueakTemp_dstIndex + 4].
							"Adjust deltaX"
							_gsSqueakTemp_deltaX := _gsSqueakTemp_deltaX + 1]
						ifFalse: ["0 < srcAlpha"
							"If we have to mix colors then just copy a
							single word"
							_gsSqueakTemp_destWord := self dstLongAt: _gsSqueakTemp_dstIndex.
							_gsSqueakTemp_destWord := self rgbComponentAlpha32: _gsSqueakTemp_sourceWord with: _gsSqueakTemp_destWord.
							self dstLongAt: _gsSqueakTemp_dstIndex put: _gsSqueakTemp_destWord.
							_gsSqueakTemp_srcIndex := _gsSqueakTemp_srcIndex + 4.
							_gsSqueakTemp_dstIndex := _gsSqueakTemp_dstIndex + 4]].
			_gsSqueakTemp_srcY := _gsSqueakTemp_srcY + 1.
			_gsSqueakTemp_dstY := _gsSqueakTemp_dstY + 1]