image save/restore
getImageHeaderFlags
	"Answer the flags that are contained in the 7th long of the image header."
	^fullScreenFlag "0 or 1"
	+ (VMBIGENDIAN ifTrue: [0] ifFalse: [2]) "this is the imageFloatsLittleEndian flag"
	+ (preemptionYields ifTrue: [0] ifFalse: [16])
	+ (imageHeaderFlags bitAnd: 19 bitInvert32) "these are any flags we do not recognize"