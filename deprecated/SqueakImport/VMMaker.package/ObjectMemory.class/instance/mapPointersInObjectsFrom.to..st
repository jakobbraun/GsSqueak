gc -- compaction
mapPointersInObjectsFrom: memStart to: memEnd
	"Use the forwarding table to update the pointers of all non-free objects in the given range of memory. Also remap pointers in root objects which may contains pointers into the given memory range, and don't forget to flush the method cache based on the range"
	self subclassResponsibility