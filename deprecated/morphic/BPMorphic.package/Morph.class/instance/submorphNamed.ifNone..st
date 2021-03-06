submorphs-accessing
submorphNamed: aName ifNone: aBlock 
	"Find the first submorph with this name, or a button with an action
	selector of that name"
	self submorphs
		do: [:p | p knownName = aName
				ifTrue: [^ p]].
	self submorphs
		do: [:button | 
			| args |
			(button respondsTo: #actionSelector)
				ifTrue: [button actionSelector == aName
						ifTrue: [^ button]].
			((button respondsTo: #arguments)
					and: [(args := button arguments) notNil])
				ifTrue: [(args
							at: 2
							ifAbsent: [])
							== aName
						ifTrue: [^ button]].
			button isAlignmentMorph
				ifTrue: [(button
						submorphNamed: aName
						ifNone: [])
						ifNotNil: [:sub | ^ sub]]].
	^ aBlock value