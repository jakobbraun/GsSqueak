*SqClasses-testing
beViewed
	"Open up a viewer on the receiver.  The Presenter is invited to decide just how to present this viewer"

	self uniqueNameForReference.  "So the viewer will have something nice to refer to"
	self presenter viewObject: self
