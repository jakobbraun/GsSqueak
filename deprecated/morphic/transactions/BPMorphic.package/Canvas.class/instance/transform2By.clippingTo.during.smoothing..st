Nebraska/embeddedWorlds
transform2By: aDisplayTransform clippingTo: aClipRect during: aBlock smoothing: cellSize 
	"an attempt to use #displayInterpolatedOn: instead of WarpBlt."
	| _gsSqueakTemp_patchRect _gsSqueakTemp_subCanvas _gsSqueakTemp_pureRect _gsSqueakTemp_biggerPatch _gsSqueakTemp_biggerClip _gsSqueakTemp_interForm |
	self flag: #bob.
	"added to Canvas in hopes it will work for Nebraska"
	aDisplayTransform isPureTranslation
		ifTrue: [^ aBlock
				value: (self copyOffset: aDisplayTransform offset negated truncated clipRect: aClipRect)].
	"Prepare an appropriate warp from patch to aClipRect"
	_gsSqueakTemp_pureRect := aDisplayTransform globalBoundsToLocal: aClipRect.
	_gsSqueakTemp_patchRect := _gsSqueakTemp_pureRect rounded.
	_gsSqueakTemp_patchRect area = 0
		ifTrue: [^ self].
	"oh, well!"
	_gsSqueakTemp_biggerPatch := _gsSqueakTemp_patchRect expandBy: 1.
	_gsSqueakTemp_biggerClip := (aDisplayTransform localBoundsToGlobal: _gsSqueakTemp_biggerPatch) rounded.
	"Render the submorphs visible in the clipping rectangle, as patchForm"
	_gsSqueakTemp_subCanvas := FormCanvas extent: _gsSqueakTemp_biggerPatch extent depth: self depth.
	self isShadowDrawing
		ifTrue: [_gsSqueakTemp_subCanvas shadowColor: self shadowColor].
	"this biggerPatch/biggerClip is an attempt to improve positioning of
	the final image in high magnification conditions. Since we cannot
	grab fractional pixels from the source, take one extra and then take
	just the part we need from the expanded form"
	_gsSqueakTemp_subCanvas translateBy: _gsSqueakTemp_biggerPatch topLeft negated rounded during: aBlock.
	_gsSqueakTemp_interForm := Form extent: _gsSqueakTemp_biggerClip extent depth: self depth.
	_gsSqueakTemp_subCanvas form displayInterpolatedIn: _gsSqueakTemp_interForm boundingBox on: _gsSqueakTemp_interForm.
	self
		drawImage: _gsSqueakTemp_interForm
		at: aClipRect origin
		sourceRect: (aClipRect origin - _gsSqueakTemp_biggerClip origin extent: aClipRect extent)