object access
instanceSizeOf: classObj 
	"Answer the number of slots in a class. For example the
	instanceSizeOf: 
	ClassPoint is 2, for the x & y slots. The instance size of non-pointer
	classes is 0."
	^ classObj instSize