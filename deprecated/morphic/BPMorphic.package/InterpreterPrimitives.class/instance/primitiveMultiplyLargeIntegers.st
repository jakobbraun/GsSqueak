arithmetic largeint primitives
primitiveMultiplyLargeIntegers
	"Primitive arithmetic operations for large integers in 64 bit range"
	| _gsSqueakTemp_a _gsSqueakTemp_b _gsSqueakTemp_result _gsSqueakTemp_oopResult _gsSqueakTemp_aIsNegative _gsSqueakTemp_bIsNegative _gsSqueakTemp_oopArg _gsSqueakTemp_oopRcvr |
	_gsSqueakTemp_oopArg := self stackValue: 0.
	_gsSqueakTemp_oopRcvr := self stackValue: 1.
	_gsSqueakTemp_aIsNegative := self isNegativeIntegerValueOf: _gsSqueakTemp_oopRcvr.
	_gsSqueakTemp_bIsNegative := self isNegativeIntegerValueOf: _gsSqueakTemp_oopArg.
	_gsSqueakTemp_a := self magnitude64BitValueOf: _gsSqueakTemp_oopRcvr.
	_gsSqueakTemp_b := self magnitude64BitValueOf: _gsSqueakTemp_oopArg.
	self successful
		ifFalse: [^ nil].
	"check for overflow"
	(_gsSqueakTemp_a > 1
			and: [_gsSqueakTemp_b > 1
					and: [_gsSqueakTemp_a > (18446744073709551615 / _gsSqueakTemp_b)]])
		ifTrue: [self primitiveFail.
			^ nil].
	_gsSqueakTemp_result := _gsSqueakTemp_a * _gsSqueakTemp_b.
	_gsSqueakTemp_oopResult := self magnitude64BitIntegerFor: _gsSqueakTemp_result neg: _gsSqueakTemp_aIsNegative ~= _gsSqueakTemp_bIsNegative.
	self successful
		ifTrue: [self pop: 2 thenPush: _gsSqueakTemp_oopResult]