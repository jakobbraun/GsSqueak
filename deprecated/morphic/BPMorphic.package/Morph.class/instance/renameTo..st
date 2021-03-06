testing
renameTo: aName 
	"Set Player name in costume. Update Viewers. Fix all tiles (old style).
	fix 
	References. New tiles: recompile, and recreate open scripts. If coming
	in 
	from disk, and have name conflict, References will already have new 
	name."
	| aPresenter putInViewer aPasteUp renderer oldKey assoc classes oldName |
	oldName := self knownName.
	oldName = aName
		ifTrue: [^ aName].
	(renderer := self topRendererOrSelf) setNameTo: aName.
	putInViewer := false.
	((aPresenter := self presenter) isNil
			or: [renderer player isNil])
		ifFalse: [putInViewer := aPresenter currentlyViewing: renderer player.
			putInViewer
				ifTrue: [renderer player viewerFlapTab hibernate]].
	"empty it temporarily"
	(aPasteUp := self topPasteUp)
		ifNotNil: [aPasteUp allTileScriptingElements
				do: [:m | m bringUpToDate]].
	"Fix References dictionary. See restoreReferences to know why oldKey
	is 
	already aName, but oldName is the old name."
	oldKey := References
				keyAtIdentityValue: renderer player
				ifAbsent: [].
	oldKey
		ifNotNil: [assoc := References associationAt: oldKey.
			oldKey = aName
				ifFalse: ["normal rename"
					assoc
						key: (renderer player uniqueNameForReferenceFrom: aName).
					References rehash]].
	putInViewer
		ifTrue: [aPresenter viewMorph: self].
	"recreate my viewer"
	oldKey
		ifNil: [^ aName].
	"Force strings in tiles to be remade with new name. New tiles only."
	Preferences universalTiles
		ifFalse: [^ aName].
	classes := (self systemNavigation allCallsOn: assoc)
				collect: [:each | each classSymbol].
	classes asSet
		do: [:clsName | (Smalltalk at: clsName)
				replaceSilently: oldName
				to: aName].
	"replace in text body of all methods. Can be wrong!"
	"Redo the tiles that are showing. This is also done in caller in 
	unhibernate."
	aPasteUp
		ifNotNil: [aPasteUp allTileScriptingElements
				do: [:mm | 
					"just ScriptEditorMorphs"
					nil.
					mm isScriptEditorMorph
						ifTrue: [((mm playerScripted class compiledMethodAt: mm scriptName)
									hasLiteral: assoc)
								ifTrue: [mm hibernate; unhibernate]]]].
	^ aName