update cycle
drawWorld: aWorld submorphs: submorphs invalidAreasOn: aCanvas 
	"Redraw the damaged areas of the given canvas and clear the damage list. Return a collection of the areas that
were redrawn."

	| rectList n morphs rects validList |
	rectList := damageRecorder invalidRectsFullBounds: aWorld viewBox.
	"sort by areas to draw largest portions first"
	rectList := rectList asArray sort: [:r1 :r2 | r1 area > r2 area].
	damageRecorder reset.
	n := submorphs size.
	morphs := OrderedCollection new: n * 2.
	rects := OrderedCollection new: n * 2.
	validList := OrderedCollection new: n * 2.

	"This is added in case we are drawing to a form that is to be used as a texture, and we want the background to be translucent."
	aWorld color isTranslucent ifTrue:
		[rectList do: [:r | aCanvas form fill: r fillColor: aWorld color]].

	rectList do: 
			[:dirtyRect | 
			dirtyRect allAreasOutsideList: validList
				do: 
					[:r | | mm rectToFill remnants c rect i | 
					"Experimental top-down drawing --
			Traverses top to bottom, stopping if the entire area is filled.
			If only a single rectangle remains, then continue with the reduced rectangle."

					rectToFill := r.
					i := 1.
					[rectToFill isNil or: [i > n]] whileFalse: 
							[mm := submorphs at: i.
							((mm fullBounds intersects: r) and: [mm visible]) 
								ifTrue: 
									[morphs addLast: mm.
									rects addLast: rectToFill.
									remnants := mm areasRemainingToFill: rectToFill.
									remnants size = 1 ifTrue: [rectToFill := remnants first].
									remnants isEmpty ifTrue: [rectToFill := nil]].
							i := i + 1].

					"Now paint from bottom to top, but using the reduced rectangles."
					rectToFill 
						ifNotNil: [(c := aCanvas copyClipRect: rectToFill) drawMorph: aWorld].
					[morphs isEmpty] whileFalse: 
							[(rect := rects removeLast) == rectToFill 
								ifFalse: [c := aCanvas copyClipRect: (rectToFill := rect)].
							c fullDrawMorph: morphs removeLast].
					morphs reset.
					rects reset.
					validList add: r]].
	^validList