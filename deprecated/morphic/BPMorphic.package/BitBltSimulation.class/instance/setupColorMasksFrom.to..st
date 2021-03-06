interpreter interface
setupColorMasksFrom: srcBits to: targetBits
  "Setup color masks for converting an incoming RGB pixel value from
	srcBits to targetBits."

  <var: #'shifts' declareC: 'static int shifts[4] = {0, 0, 0, 0}'>
  <var: #'masks' declareC: 'static unsigned int masks[4] = {0, 0, 0, 0}'>
  | _gsSqueakTemp_mask _gsSqueakTemp_shifts _gsSqueakTemp_masks _gsSqueakTemp_deltaBits |
  self
    cCode: ''
    inSmalltalk: [ 
      _gsSqueakTemp_shifts := CArrayAccessor on: (Array new: 4).
      _gsSqueakTemp_masks := CArrayAccessor on: (WordArray new: 4) ].
  _gsSqueakTemp_deltaBits := targetBits - srcBits.
  _gsSqueakTemp_deltaBits = 0
    ifTrue: [ ^ 0 ].
  _gsSqueakTemp_deltaBits <= 0
    ifTrue: [ 
      _gsSqueakTemp_mask := (1 << targetBits) - 1.	"Mask for extracting a color part of the source"
      _gsSqueakTemp_masks
        at: RedIndex
        put: _gsSqueakTemp_mask << (srcBits * 2 - _gsSqueakTemp_deltaBits).
      _gsSqueakTemp_masks
        at: GreenIndex
        put: _gsSqueakTemp_mask << (srcBits - _gsSqueakTemp_deltaBits).
      _gsSqueakTemp_masks
        at: BlueIndex
        put: _gsSqueakTemp_mask << (0 - _gsSqueakTemp_deltaBits).
      _gsSqueakTemp_masks at: AlphaIndex put: 0 ]
    ifFalse: [ 
      _gsSqueakTemp_mask := (1 << srcBits) - 1.	"Mask for extracting a color part of the source"
      _gsSqueakTemp_masks at: RedIndex put: _gsSqueakTemp_mask << (srcBits * 2).
      _gsSqueakTemp_masks at: GreenIndex put: _gsSqueakTemp_mask << srcBits.
      _gsSqueakTemp_masks at: BlueIndex put: _gsSqueakTemp_mask ].	"Shifts for adjusting each value in a cm RGB value"
  _gsSqueakTemp_shifts at: RedIndex put: _gsSqueakTemp_deltaBits * 3.
  _gsSqueakTemp_shifts at: GreenIndex put: _gsSqueakTemp_deltaBits * 2.
  _gsSqueakTemp_shifts at: BlueIndex put: _gsSqueakTemp_deltaBits.
  _gsSqueakTemp_shifts at: AlphaIndex put: 0.
  cmShiftTable := _gsSqueakTemp_shifts.
  cmMaskTable := _gsSqueakTemp_masks.
  cmFlags := cmFlags bitOr: (ColorMapPresent bitOr: ColorMapFixedPart)