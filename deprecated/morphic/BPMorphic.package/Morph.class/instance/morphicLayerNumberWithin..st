WiW support
morphicLayerNumberWithin: anOwner
  "helpful for insuring some morphs always appear in front of or behind
	others. smaller numbers are in front"

  ^ (self owner isNil
    or: [ self owner isWorldMorph or: [ anOwner == self owner ] ])
    ifTrue: [ self valueOfProperty: #'morphicLayerNumber' ifAbsent: [ 100 ] ]
    ifFalse: [ self owner morphicLayerNumber ]	"leave lots of room for special things"