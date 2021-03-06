combination rules
alphaBlendConst: sourceWord with: destinationWord paintMode: paintMode 
	"Blend sourceWord with destinationWord using a constant alpha.
	Alpha is encoded as 0 meaning 0.0, and 255 meaning 1.0.
	The blend produced is alpha*source + (1.0-alpha)*dest, with the
	computation being performed independently on each color
	component. This function could eventually blend into any depth
	destination, using the same color averaging and mapping as warpBlt.
	paintMode = true means do nothing if the source pixel value is zero."
	"This first implementation works with dest depths of 16 and 32 bits
	only. Normal color mapping will allow sources of lower depths in this
	case, and results can be mapped directly by truncation, so no extra
	color maps are needed.
	To allow storing into any depth will require subsequent addition of two
	other colormaps, as is the case with WarpBlt."
	| _gsSqueakTemp_pixMask _gsSqueakTemp_destShifted _gsSqueakTemp_sourceShifted _gsSqueakTemp_destPixVal _gsSqueakTemp_rgbMask _gsSqueakTemp_sourcePixVal _gsSqueakTemp_unAlpha _gsSqueakTemp_result _gsSqueakTemp_pixBlend _gsSqueakTemp_shift _gsSqueakTemp_blend _gsSqueakTemp_maskShifted _gsSqueakTemp_bitsPerColor _gsSqueakTemp_blendAG _gsSqueakTemp_blendRB |
	<inline: false>
	<return: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>
	<var: #blendRB type: 'unsigned int'>
	<var: #blendAG type: 'unsigned int'>
	<var: #result type: 'unsigned int'>
	<var: #sourceAlpha type: 'unsigned int'>
	<var: #unAlpha type: 'unsigned int'>
	destDepth < 16
		ifTrue: [^ destinationWord"no-op"].
	_gsSqueakTemp_unAlpha := 255 - sourceAlpha.
	_gsSqueakTemp_result := destinationWord.
	destPPW = 1
		ifTrue: ["32bpp blends include alpha"
			paintMode & (sourceWord = 0)
				ifFalse: ["painting a transparent pixel"
					_gsSqueakTemp_blendRB := (sourceWord bitAnd: 16711935)
								* sourceAlpha + ((destinationWord bitAnd: 16711935)
									* _gsSqueakTemp_unAlpha) + 16711935.
					"blendRB red and blue"
					_gsSqueakTemp_blendAG := (sourceWord >> 8 bitAnd: 16711935)
								* sourceAlpha + ((destinationWord >> 8 bitAnd: 16711935)
									* _gsSqueakTemp_unAlpha) + 16711935.
					"blendRB alpha and green"
					_gsSqueakTemp_blendRB := _gsSqueakTemp_blendRB
								+ (_gsSqueakTemp_blendRB - 65537 >> 8 bitAnd: 16711935) >> 8 bitAnd: 16711935.
					"divide by 255"
					_gsSqueakTemp_blendAG := _gsSqueakTemp_blendAG
								+ (_gsSqueakTemp_blendAG - 65537 >> 8 bitAnd: 16711935) >> 8 bitAnd: 16711935.
					_gsSqueakTemp_result := _gsSqueakTemp_blendRB bitOr: _gsSqueakTemp_blendAG << 8]]
		ifFalse: [_gsSqueakTemp_pixMask := maskTable at: destDepth.
			_gsSqueakTemp_bitsPerColor := 5.
			_gsSqueakTemp_rgbMask := 31.
			_gsSqueakTemp_maskShifted := destMask.
			_gsSqueakTemp_destShifted := destinationWord.
			_gsSqueakTemp_sourceShifted := sourceWord.
			1
				to: destPPW
				do: [:j | 
					_gsSqueakTemp_sourcePixVal := _gsSqueakTemp_sourceShifted bitAnd: _gsSqueakTemp_pixMask.
					((_gsSqueakTemp_maskShifted bitAnd: _gsSqueakTemp_pixMask)
								= 0
							or: ["no effect if outside of dest rectangle"
								paintMode & (_gsSqueakTemp_sourcePixVal = 0)
								"or painting a transparent pixel"])
						ifFalse: [_gsSqueakTemp_destPixVal := _gsSqueakTemp_destShifted bitAnd: _gsSqueakTemp_pixMask.
							_gsSqueakTemp_pixBlend := 0.
							1
								to: 3
								do: [:i | 
									_gsSqueakTemp_shift := i - 1 * _gsSqueakTemp_bitsPerColor.
									_gsSqueakTemp_blend := (_gsSqueakTemp_sourcePixVal >> _gsSqueakTemp_shift bitAnd: _gsSqueakTemp_rgbMask)
												* sourceAlpha + ((_gsSqueakTemp_destPixVal >> _gsSqueakTemp_shift bitAnd: _gsSqueakTemp_rgbMask)
													* _gsSqueakTemp_unAlpha) + 254 // 255 bitAnd: _gsSqueakTemp_rgbMask.
									_gsSqueakTemp_pixBlend := _gsSqueakTemp_pixBlend bitOr: _gsSqueakTemp_blend << _gsSqueakTemp_shift].
							_gsSqueakTemp_result := (_gsSqueakTemp_result bitAnd: (_gsSqueakTemp_pixMask << (j - 1 * 16)) bitInvert32)
										bitOr: _gsSqueakTemp_pixBlend << (j - 1 * 16)].
					_gsSqueakTemp_maskShifted := _gsSqueakTemp_maskShifted >> destDepth.
					_gsSqueakTemp_sourceShifted := _gsSqueakTemp_sourceShifted >> destDepth.
					_gsSqueakTemp_destShifted := _gsSqueakTemp_destShifted >> destDepth]].
	^ _gsSqueakTemp_result