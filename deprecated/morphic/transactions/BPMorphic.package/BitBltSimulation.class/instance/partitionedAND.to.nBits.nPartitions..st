combination rules
partitionedAND: word1 to: word2 nBits: nBits nPartitions: nParts 
	"AND word1 to word2 as nParts partitions of nBits each.
	Any field of word1 not all-ones is treated as all-zeroes.
	Used for erasing, eg, brush shapes prior to ORing in a color"
	| _gsSqueakTemp_mask _gsSqueakTemp_result |
	_gsSqueakTemp_mask := maskTable at: nBits.
	"partition mask starts at the right"
	_gsSqueakTemp_result := 0.
	1
		to: nParts
		do: [:i | 
			(word1 bitAnd: _gsSqueakTemp_mask)
					= _gsSqueakTemp_mask
				ifTrue: [_gsSqueakTemp_result := _gsSqueakTemp_result
								bitOr: (word2 bitAnd: _gsSqueakTemp_mask)].
			_gsSqueakTemp_mask := _gsSqueakTemp_mask << nBits
			"slide left to next partition"].
	^ _gsSqueakTemp_result