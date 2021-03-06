world menu
makeNewDrawing: evt at: aPoint 
	"make a new drawing, triggered by the given event, with the painting
	area centered around the given point"
	| w newSketch newPlayer sketchEditor aPalette rect aPaintBox aPaintTab aWorld |
	w := self world.
	w
		assureNotPaintingElse: [^ self].
	rect := self paintingBoundsAround: aPoint.
	aPalette := self standardPalette.
	aPalette
		ifNotNil: [aPalette showNoPalette; layoutChanged].
	w prepareToPaint.
	newSketch := self drawingClass new.
	Smalltalk
		at: #UnscriptedPlayer
		ifPresent: [:aClass | 
			newSketch player: (newPlayer := aClass newUserInstance).
			newPlayer costume: newSketch].
	newSketch
		nominalForm: (Form extent: rect extent depth: w assuredCanvas depth).
	newSketch bounds: rect.
	sketchEditor := SketchEditorMorph new.
	w addMorphFront: sketchEditor.
	sketchEditor
		initializeFor: newSketch
		inBounds: rect
		pasteUpMorph: self.
	sketchEditor
		afterNewPicDo: [:aForm :aRect | 
			| tfx ownerBeforeHack whereToPresent |
			whereToPresent := self presenter.
			newSketch form: aForm.
			tfx := self transformFrom: w.
			newSketch
				position: (tfx globalPointToLocal: aRect origin).
			newSketch rotationStyle: sketchEditor rotationStyle.
			newSketch forwardDirection: sketchEditor forwardDirection.
			ownerBeforeHack := newSketch owner.
			"about to break the invariant!!"
			newSketch privateOwner: self.
			"temp for halo access"
			newPlayer
				ifNotNil: [newPlayer setHeading: sketchEditor forwardDirection].
			(aPaintTab := (aWorld := self world) paintingFlapTab)
				ifNil: [(aPaintBox := aWorld paintBox)
						ifNotNil: [aPaintBox delete]]
				ifNotNil: [aPaintTab hideFlap].
			"Includes newSketch rotationDegrees: sketchEditor
			forwardDirection. "
			newSketch privateOwner: ownerBeforeHack.
			"probably nil, but let's be certain"
			self
				addMorphFront: (newPlayer
						ifNil: [newSketch]
						ifNotNil: [newPlayer costume]).
			w startSteppingSubmorphsOf: newSketch.
			whereToPresent drawingJustCompleted: newSketch]
		ifNoBits: [(aPaintTab := (aWorld := self world) paintingFlapTab)
				ifNil: [(aPaintBox := aWorld paintBox)
						ifNotNil: [aPaintBox delete]]
				ifNotNil: [aPaintTab hideFlap].
			aPalette
				ifNotNil: [aPalette showNoPalette]]