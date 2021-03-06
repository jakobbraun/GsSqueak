combination rules
alphaBlendScaled: sourceWord with: destinationWord 
	"Blend sourceWord with destinationWord using the alpha value from
	sourceWord. Alpha is encoded as 0 meaning 0.0, and 255 meaning
	1.0. In contrast to alphaBlend:with: the color produced is
	
	srcColor + (1-srcAlpha) * dstColor
	
	e.g., it is assumed that the source color is already scaled."
	| _gsSqueakTemp_unAlpha _gsSqueakTemp_rb _gsSqueakTemp_ag |
	<inline: false>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>
	<var: #rb type: 'unsigned int'>
	<var: #ag type: 'unsigned int'>
	<var: #unAlpha type: 'unsigned int'>
	"Do NOT inline this into optimized loops"
	_gsSqueakTemp_unAlpha := 255 - (sourceWord >> 24).
	"High 8 bits of source pixel is source opacity (ARGB format)"
	_gsSqueakTemp_rb := ((destinationWord bitAnd: 16711935)
				* _gsSqueakTemp_unAlpha >> 8 bitAnd: 16711935)
				+ (sourceWord bitAnd: 16711935).
	"blend red and blue components"
	_gsSqueakTemp_ag := ((destinationWord >> 8 bitAnd: 16711935)
				* _gsSqueakTemp_unAlpha >> 8 bitAnd: 16711935)
				+ (sourceWord >> 8 bitAnd: 16711935).
	"blend alpha and green components"
	_gsSqueakTemp_rb := (_gsSqueakTemp_rb bitAnd: 16711935)
				bitOr: (_gsSqueakTemp_rb bitAnd: 16777472)
						* 255 >> 8.
	"saturate red and blue components if there is a carry"
	_gsSqueakTemp_ag := (_gsSqueakTemp_ag bitAnd: 16711935)
				<< 8 bitOr: (_gsSqueakTemp_ag bitAnd: 16777472)
					* 255.
	"saturate alpha and green components if there is a carry"
	^ _gsSqueakTemp_ag bitOr: _gsSqueakTemp_rb"recompose"