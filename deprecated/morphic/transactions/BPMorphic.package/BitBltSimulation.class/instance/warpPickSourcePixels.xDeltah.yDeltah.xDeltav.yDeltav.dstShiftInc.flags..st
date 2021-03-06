pixel mapping
warpPickSourcePixels: nPixels xDeltah: xDeltah yDeltah: yDeltah xDeltav: xDeltav yDeltav: yDeltav dstShiftInc: dstShiftInc flags: mapperFlags 
	"Pick n pixels from the source form,
	map by colorMap and return aligned by dstBitShift.
	This version is only called from WarpBlt with smoothingCount = 1"
	| _gsSqueakTemp_dstMask _gsSqueakTemp_destWord _gsSqueakTemp_nPix _gsSqueakTemp_sourcePix _gsSqueakTemp_destPix |
	<inline: true>
	"Yepp - this should go into warpLoop"
	_gsSqueakTemp_dstMask := maskTable at: destDepth.
	_gsSqueakTemp_destWord := 0.
	_gsSqueakTemp_nPix := nPixels.
	mapperFlags
			= (ColorMapPresent bitOr: ColorMapIndexedPart)
		ifTrue: ["a little optimization for (pretty crucial) blits using indexed
			lookups only"
			"grab, colormap and mix in pixel"
			[_gsSqueakTemp_sourcePix := self pickWarpPixelAtX: sx y: sy.
			_gsSqueakTemp_destPix := cmLookupTable
						at: (_gsSqueakTemp_sourcePix bitAnd: cmMask).
			_gsSqueakTemp_destWord := _gsSqueakTemp_destWord bitOr: (_gsSqueakTemp_destPix bitAnd: _gsSqueakTemp_dstMask)
							<< dstBitShift.
			dstBitShift := dstBitShift + dstShiftInc.
			sx := sx + xDeltah.
			sy := sy + yDeltah.
			(_gsSqueakTemp_nPix := _gsSqueakTemp_nPix - 1) = 0] whileFalse]
		ifFalse: ["grab, colormap and mix in pixel"
			[_gsSqueakTemp_sourcePix := self pickWarpPixelAtX: sx y: sy.
			_gsSqueakTemp_destPix := self mapPixel: _gsSqueakTemp_sourcePix flags: mapperFlags.
			_gsSqueakTemp_destWord := _gsSqueakTemp_destWord bitOr: (_gsSqueakTemp_destPix bitAnd: _gsSqueakTemp_dstMask)
							<< dstBitShift.
			dstBitShift := dstBitShift + dstShiftInc.
			sx := sx + xDeltah.
			sy := sy + yDeltah.
			(_gsSqueakTemp_nPix := _gsSqueakTemp_nPix - 1) = 0] whileFalse].
	^ _gsSqueakTemp_destWord