menus
reasonableBitmapFillForms
	"Answer an OrderedCollection of forms that could be used to replace
	my bitmap fill, with my current form first."
	| reasonableForms myGraphic |
	reasonableForms := self class allSketchMorphForms.
	reasonableForms addAll: Imports default images.
	reasonableForms
		addAll: (BitmapFillStyle allSubInstances
				collect: [:f | f form]).
	reasonableForms
		remove: (myGraphic := self fillStyle form)
		ifAbsent: [].
	reasonableForms := reasonableForms asOrderedCollection.
	reasonableForms addFirst: myGraphic.
	^ reasonableForms