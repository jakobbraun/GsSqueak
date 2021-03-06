combination rules
pixSwap: sourceWord with: destWord 
	"Swap the pixels in destWord"
	| _gsSqueakTemp_result _gsSqueakTemp_shift _gsSqueakTemp_lowMask _gsSqueakTemp_highMask |
	<inline: false>
	destPPW = 1
		ifTrue: [^ destWord].
	"a single pixel per word"
	_gsSqueakTemp_result := 0.
	_gsSqueakTemp_lowMask := 1 << destDepth - 1.
	"mask low pixel"
	_gsSqueakTemp_highMask := _gsSqueakTemp_lowMask << (destPPW - 1 * destDepth).
	"mask high pixel"
	_gsSqueakTemp_shift := 32 - destDepth.
	_gsSqueakTemp_result := _gsSqueakTemp_result
				bitOr: ((destWord bitAnd: _gsSqueakTemp_lowMask)
						<< _gsSqueakTemp_shift bitOr: (destWord bitAnd: _gsSqueakTemp_highMask)
							>> _gsSqueakTemp_shift).
	destPPW <= 2
		ifTrue: [^ _gsSqueakTemp_result].
	2
		to: destPPW // 2
		do: [:i | 
			_gsSqueakTemp_lowMask := _gsSqueakTemp_lowMask << destDepth.
			_gsSqueakTemp_highMask := _gsSqueakTemp_highMask >> destDepth.
			_gsSqueakTemp_shift := _gsSqueakTemp_shift - (destDepth * 2).
			_gsSqueakTemp_result := _gsSqueakTemp_result
						bitOr: ((destWord bitAnd: _gsSqueakTemp_lowMask)
								<< _gsSqueakTemp_shift bitOr: (destWord bitAnd: _gsSqueakTemp_highMask)
									>> _gsSqueakTemp_shift)].
	^ _gsSqueakTemp_result