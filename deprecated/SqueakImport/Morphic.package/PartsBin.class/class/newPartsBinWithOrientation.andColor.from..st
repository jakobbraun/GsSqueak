instance creation
newPartsBinWithOrientation: aListDirection andColor: aColor from: quadList 
	"Answer a new PartBin object, to run horizontally or vertically,  
	obtaining its elements from the list of tuples of the form:  
	(<receiver> <selector> <label> <balloonHelp>)"
	^ (self new)
		color: aColor;
		listDirection: aListDirection quadList: (self translatedQuads: quadList).