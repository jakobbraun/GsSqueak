updating
updateUpButtonImage
	"update the receiver's upButton. put a new image inside"
	upButton removeAllMorphs.
	upButton
		addMorphCentered: (ImageMorph new image: self upImage)