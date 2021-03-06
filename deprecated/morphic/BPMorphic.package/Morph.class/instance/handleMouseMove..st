events-processing
handleMouseMove: anEvent 
	"System level event handling."
	anEvent wasHandled
		ifTrue: [^ self].
	"not interested"
	(self handlesMouseMove: anEvent)
		ifFalse: [^ self].
	anEvent wasHandled: true.
	self mouseMove: anEvent.
	(self handlesMouseStillDown: anEvent)
		ifTrue: ["Step at the new location"
			self
				startStepping: #handleMouseStillDown:
				at: Time millisecondClockValue
				arguments: {anEvent copy resetHandlerFields}
				stepTime: self mouseStillDownStepRate]