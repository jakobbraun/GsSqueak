boundaries
normalizedX: x 
	^ (x max: self leftBoundary)
		min: self rightBoundary