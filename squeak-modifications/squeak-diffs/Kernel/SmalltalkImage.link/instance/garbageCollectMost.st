memory space
garbageCollectMost
	"Primitive. Reclaims recently created garbage (which is usually most of it) fairly quickly and answers the number of bytes of available space."

	
	^ self primBytesLeft
