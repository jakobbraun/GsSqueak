combination rules
pickSourcePixels: nPixels flags: mapperFlags srcMask: srcMask destMask: dstMask srcShiftInc: srcShiftInc dstShiftInc: dstShiftInc 
	"Pick nPix pixels starting at srcBitIndex from the source, map by the
	color map, and justify them according to dstBitIndex in the resulting
	destWord. "
	| _gsSqueakTemp_sourceWord _gsSqueakTemp_destWord _gsSqueakTemp_sourcePix _gsSqueakTemp_destPix _gsSqueakTemp_srcShift _gsSqueakTemp_dstShift _gsSqueakTemp_nPix |
	<inline: true>
	"oh please"
	_gsSqueakTemp_sourceWord := self srcLongAt: sourceIndex.
	_gsSqueakTemp_destWord := 0.
	_gsSqueakTemp_srcShift := srcBitShift.
	"Hint: Keep in register"
	_gsSqueakTemp_dstShift := dstBitShift.
	"Hint: Keep in register"
	_gsSqueakTemp_nPix := nPixels.
	"always > 0 so we can use do { } while(--nPix);"
	mapperFlags
			= (ColorMapPresent bitOr: ColorMapIndexedPart)
		ifTrue: ["a little optimization for (pretty crucial) blits using indexed
			lookups only"
			"grab, colormap and mix in pixel"
			[_gsSqueakTemp_sourcePix := _gsSqueakTemp_sourceWord >> _gsSqueakTemp_srcShift bitAnd: srcMask.
			_gsSqueakTemp_destPix := cmLookupTable
						at: (_gsSqueakTemp_sourcePix bitAnd: cmMask).
			_gsSqueakTemp_destWord := _gsSqueakTemp_destWord bitOr: (_gsSqueakTemp_destPix bitAnd: dstMask)
							<< _gsSqueakTemp_dstShift.
			"adjust dest pix index"
			_gsSqueakTemp_dstShift := _gsSqueakTemp_dstShift + dstShiftInc.
			"adjust source pix index"
			((_gsSqueakTemp_srcShift := _gsSqueakTemp_srcShift + srcShiftInc) bitAnd: 4294967264)
					= 0
				ifFalse: [sourceMSB
						ifTrue: [_gsSqueakTemp_srcShift := _gsSqueakTemp_srcShift + 32]
						ifFalse: [_gsSqueakTemp_srcShift := _gsSqueakTemp_srcShift - 32].
					_gsSqueakTemp_sourceWord := self srcLongAt: (sourceIndex := sourceIndex + 4)].
			(_gsSqueakTemp_nPix := _gsSqueakTemp_nPix - 1) = 0] whileFalse]
		ifFalse: ["grab, colormap and mix in pixel"
			[_gsSqueakTemp_sourcePix := _gsSqueakTemp_sourceWord >> _gsSqueakTemp_srcShift bitAnd: srcMask.
			_gsSqueakTemp_destPix := self mapPixel: _gsSqueakTemp_sourcePix flags: mapperFlags.
			_gsSqueakTemp_destWord := _gsSqueakTemp_destWord bitOr: (_gsSqueakTemp_destPix bitAnd: dstMask)
							<< _gsSqueakTemp_dstShift.
			"adjust dest pix index"
			_gsSqueakTemp_dstShift := _gsSqueakTemp_dstShift + dstShiftInc.
			"adjust source pix index"
			((_gsSqueakTemp_srcShift := _gsSqueakTemp_srcShift + srcShiftInc) bitAnd: 4294967264)
					= 0
				ifFalse: [sourceMSB
						ifTrue: [_gsSqueakTemp_srcShift := _gsSqueakTemp_srcShift + 32]
						ifFalse: [_gsSqueakTemp_srcShift := _gsSqueakTemp_srcShift - 32].
					_gsSqueakTemp_sourceWord := self srcLongAt: (sourceIndex := sourceIndex + 4)].
			(_gsSqueakTemp_nPix := _gsSqueakTemp_nPix - 1) = 0] whileFalse].
	srcBitShift := _gsSqueakTemp_srcShift.
	"Store back"
	^ _gsSqueakTemp_destWord