event handling
mouseWheel: anEvent 
	"Handle a mouse wheel event. The default response is to let my
	eventHandler, if any, handle it."
	self eventHandler
		ifNotNil: [:handler | handler mouseWheel: anEvent fromMorph: self]