fileIn/out
saveOnURL
	"Ask the user for a url and save myself on a SmartReferenceStream file.  Writes out the version and class structure.  The file is fileIn-able.  UniClasses will be filed out."

	| um pg |
	(pg := self saveOnURLbasic) == #cancel ifTrue: [^ self].
	um := URLMorph newForURL: pg url.
	um setURL: pg url page: pg.
	pg isContentsInMemory ifTrue: [pg computeThumbnail].
	um isBookmark: true.
	um removeAllMorphs.
	um color: Color transparent.
	self primaryHand attachMorph: um.