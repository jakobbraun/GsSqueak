resize handling
doFastWindowReframe: ptName 
	"For fast display, only higlight the rectangle during loop"
	| newBounds |
	newBounds := self bounds
				newRectButtonPressedDo: [:f | f
						withSideOrCorner: ptName
						setToPoint: (self pointFromWorld: Sensor cursorPoint)
						minExtent: self minimumExtent].
	self bounds: newBounds.
	^ newBounds