menus
maybeAddCollapseItemTo: aMenu 
	"If appropriate, add a collapse item to the given menu"
	self topRendererOrSelf owner
		ifNotNil: [:anOwner | anOwner isWorldMorph
				ifTrue: [aMenu
						add: 'collapse' translated
						target: self
						action: #collapse]]