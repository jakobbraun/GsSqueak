interpreter access
fetchByte: byteIndex ofObject: oop

	^ self byteAt: oop + self baseHeaderSize + byteIndex