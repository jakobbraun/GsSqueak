event handling
mouseEnter: event
	hasFocus := true.
	owner isSystemWindow ifTrue: [owner paneTransition: event].
	retractableScrollBar ifTrue: [self hideOrShowScrollBars].