*SqClasses-error handling
subclassResponsibility
	"This message sets up a framework for the behavior of the class' subclasses.
	Announce that the subclass should have implemented this message."
	^ SubclassResponsibility
		signal: ('My {1} subclass should have overridden {2}'
			format: {self className. thisContext sender selector}).
