*SqClasses-tracing
outboundPointers
"Answers a list of all objects I am causing not to be garbage-collected"

	| collection |
	collection := OrderedCollection new.
	self outboundPointersDo: [:ea | collection add: ea].
	^ collection
