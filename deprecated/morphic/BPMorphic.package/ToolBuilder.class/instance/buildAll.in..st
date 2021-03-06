building
buildAll: aList in: newParent 
	"Build the given set of widgets in the new parent"
	| _gsSqueakTemp_prior |
	aList
		ifNil: [^ self].
	_gsSqueakTemp_prior := parent.
	parent := newParent.
	aList
		do: [:each | each buildWith: self].
	parent := _gsSqueakTemp_prior