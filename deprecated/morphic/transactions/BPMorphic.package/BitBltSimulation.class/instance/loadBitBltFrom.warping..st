interpreter interface
loadBitBltFrom: bbObj warping: aBool
  "Load context from BitBlt instance. Return false if anything is amiss"

  "NOTE this should all be changed to minX/maxX coordinates for
	simpler clipping
	-- once it works!"

  <inline: false>
  | _gsSqueakTemp_ok |
  bitBltOop := bbObj.
  isWarping := aBool.
  combinationRule := interpreterProxy
    fetchInteger: BBRuleIndex
    ofObject: bitBltOop.
  (interpreterProxy failed
    or: [ combinationRule < 0 or: [ combinationRule > (OpTableSize - 2) ] ])
    ifTrue: [ 
      self halt.
      ^ false	"non-integer value" ].
  (combinationRule >= 16 and: [ combinationRule <= 17 ])
    ifTrue: [ 
      self halt.
      ^ false	"non-integer value" ].
  sourceForm := interpreterProxy
    fetchPointer: BBSourceFormIndex
    ofObject: bitBltOop.
  noSource := self ignoreSourceOrHalftone: sourceForm.
  halftoneForm := interpreterProxy
    fetchPointer: BBHalftoneFormIndex
    ofObject: bitBltOop.
  noHalftone := self ignoreSourceOrHalftone: halftoneForm.
  destForm := interpreterProxy fetchPointer: BBDestFormIndex ofObject: bbObj.
  ((interpreterProxy isPointers: destForm)
    and: [ (interpreterProxy slotSizeOf: destForm) >= 4 ])
    ifFalse: [ 
      self halt.
      ^ false	"non-integer value" ].
  _gsSqueakTemp_ok := self loadBitBltDestForm.
  _gsSqueakTemp_ok
    ifFalse: [ 
      self halt.
      ^ false	"non-integer value" ].
  destX := self fetchIntOrFloat: BBDestXIndex ofObject: bitBltOop ifNil: 0.
  destY := self fetchIntOrFloat: BBDestYIndex ofObject: bitBltOop ifNil: 0.
  width := self
    fetchIntOrFloat: BBWidthIndex
    ofObject: bitBltOop
    ifNil: destWidth.
  height := self
    fetchIntOrFloat: BBHeightIndex
    ofObject: bitBltOop
    ifNil: destHeight.
  interpreterProxy failed
    ifTrue: [ 
      self halt.
      ^ false	"non-integer value" ].
  noSource
    ifTrue: [ sourceX := sourceY := 0 ]
    ifFalse: [ 
      ((interpreterProxy isPointers: sourceForm)
        and: [ (interpreterProxy slotSizeOf: sourceForm) >= 4 ])
        ifFalse: [ 
          self halt.
          ^ false	"non-integer value" ].
      _gsSqueakTemp_ok := self loadBitBltSourceForm.
      _gsSqueakTemp_ok
        ifFalse: [ 
          self halt.
          ^ false	"non-integer value" ].
      _gsSqueakTemp_ok := self loadColorMap.
      _gsSqueakTemp_ok
        ifFalse: [ 
          self halt.
          ^ false	"non-integer value" ].	"Need the implicit setup here in case of 16<->32 bit
			conversions "
      (cmFlags bitAnd: ColorMapNewStyle) = 0
        ifTrue: [ self setupColorMasks ].
      sourceX := self
        fetchIntOrFloat: BBSourceXIndex
        ofObject: bitBltOop
        ifNil: 0.
      sourceY := self
        fetchIntOrFloat: BBSourceYIndex
        ofObject: bitBltOop
        ifNil: 0 ].
  _gsSqueakTemp_ok := self loadHalftoneForm.
  _gsSqueakTemp_ok
    ifFalse: [ 
      self halt.
      ^ false	"non-integer value" ].
  clipX := self fetchIntOrFloat: BBClipXIndex ofObject: bitBltOop ifNil: 0.
  clipY := self fetchIntOrFloat: BBClipYIndex ofObject: bitBltOop ifNil: 0.
  clipWidth := self
    fetchIntOrFloat: BBClipWidthIndex
    ofObject: bitBltOop
    ifNil: destWidth.
  clipHeight := self
    fetchIntOrFloat: BBClipHeightIndex
    ofObject: bitBltOop
    ifNil: destHeight.
  interpreterProxy failed
    ifTrue: [ 
      self halt.
      ^ false	"non-integer value" ].
  clipX < 0
    ifTrue: [ 
      clipWidth := clipWidth + clipX.
      clipX := 0 ].
  clipY < 0
    ifTrue: [ 
      clipHeight := clipHeight + clipY.
      clipY := 0 ].
  clipX + clipWidth > destWidth
    ifTrue: [ clipWidth := destWidth - clipX ].
  clipY + clipHeight > destHeight
    ifTrue: [ clipHeight := destHeight - clipY ].
  ^ true