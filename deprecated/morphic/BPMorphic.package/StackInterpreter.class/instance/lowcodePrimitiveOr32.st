inline primitive generated code
lowcodePrimitiveOr32
	"Lowcode instruction generator"
	| _gsSqueakTemp_second _gsSqueakTemp_result _gsSqueakTemp_first |
	_gsSqueakTemp_second := self internalPopStackInt32.
	_gsSqueakTemp_first := self internalPopStackInt32.
	_gsSqueakTemp_result := _gsSqueakTemp_first bitOr: _gsSqueakTemp_second.
	self internalPushInt32: _gsSqueakTemp_result