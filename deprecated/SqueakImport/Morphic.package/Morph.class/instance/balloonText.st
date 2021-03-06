accessing
balloonText
	"Answer balloon help text or nil, if no help is available.  
	NB: subclasses may override such that they programatically  
	construct the text, for economy's sake, such as model phrases in 
	a Viewer"

	| result |
	extension ifNil: [^nil].
	
	extension balloonText
		ifNotNil: [:balloonText | result := balloonText]
		ifNil: [extension balloonTextSelector
			ifNotNil: [:balloonSelector |
				result := ScriptingSystem helpStringOrNilFor: balloonSelector.
				(result isNil and: [balloonSelector == #methodComment]) 
					ifTrue: [result := self methodCommentAsBalloonHelp].
				((result isNil and: [balloonSelector numArgs = 0]) 
					and: [self respondsTo: balloonSelector]) 
						ifTrue: [result := self perform: balloonSelector]]].
	^ result