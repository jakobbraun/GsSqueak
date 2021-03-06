memory access
dstLongAt: idx put: srcValue mask: dstMask 
	"Store the given value back into destination form, using dstMask
	to mask out the bits to be modified. This is an essiantial
	read-modify-write operation on the destination form."
	| _gsSqueakTemp_dstValue |
	<inline: true>
	_gsSqueakTemp_dstValue := self dstLongAt: idx.
	_gsSqueakTemp_dstValue := _gsSqueakTemp_dstValue bitAnd: dstMask.
	_gsSqueakTemp_dstValue := _gsSqueakTemp_dstValue bitOr: srcValue.
	self dstLongAt: idx put: _gsSqueakTemp_dstValue