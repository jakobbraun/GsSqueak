world state
assureNotPaintingEvent: evt 
	"If painting is already underway
	in the receiver, put up an informer to that effect and evalute aBlock"
	self sketchEditorOrNil
		ifNotNil: [:editor | 
			editor save: evt.
			Cursor normal show]