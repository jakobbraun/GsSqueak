pixel mapping
pickWarpPixelAtX: xx y: yy 
	"Pick a single pixel from the source for WarpBlt.
	Note: This method is crucial for WarpBlt speed w/o smoothing
	and still relatively important when smoothing is used."
	| _gsSqueakTemp_x _gsSqueakTemp_y _gsSqueakTemp_srcIndex _gsSqueakTemp_sourceWord _gsSqueakTemp_sourcePix |
	<inline: true>
	"*please*"
	"note: it would be much faster if we could just
	avoid these stupid tests for being inside sourceForm."
	(xx < 0
			or: [yy < 0
					or: [(_gsSqueakTemp_x := xx >> BinaryPoint) >= sourceWidth
							or: [(_gsSqueakTemp_y := yy >> BinaryPoint) >= sourceHeight]]])
		ifTrue: [^ 0].
	"out of bounds"
	"Fetch source word.
	Note: We should really update srcIndex with sx and sy so that
	we don't have to do the computation below. We might even be
	able to simplify the out of bounds test from above."
	_gsSqueakTemp_srcIndex := sourceBits + (_gsSqueakTemp_y * sourcePitch) + (_gsSqueakTemp_x >> warpAlignShift * 4).
	_gsSqueakTemp_sourceWord := self srcLongAt: _gsSqueakTemp_srcIndex.
	"Extract pixel from word"
	srcBitShift := warpBitShiftTable
				at: (_gsSqueakTemp_x bitAnd: warpAlignMask).
	_gsSqueakTemp_sourcePix := _gsSqueakTemp_sourceWord >> srcBitShift bitAnd: warpSrcMask.
	^ _gsSqueakTemp_sourcePix