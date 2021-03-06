drawing
line: pt1 to: pt2 width: width color: color1 dashLength: s1 secondColor: color2 secondDashLength: s2 startingOffset: startingOffset 
	"Draw a line using the given width, colors and dash lengths.
	Originally written by Stephan Rudlof; tweaked by Dan Ingalls
	to use startingOffset for sliding offset as in 'ants' animations.
	Returns the sum of the starting offset and the length of this line."
	| _gsSqueakTemp_dist _gsSqueakTemp_deltaBig _gsSqueakTemp_colors _gsSqueakTemp_nextPhase _gsSqueakTemp_segmentOffset _gsSqueakTemp_phase _gsSqueakTemp_segmentLength _gsSqueakTemp_startPoint _gsSqueakTemp_distDone _gsSqueakTemp_endPoint _gsSqueakTemp_segLens |
	_gsSqueakTemp_dist := pt1 dist: pt2.
	_gsSqueakTemp_dist = 0
		ifTrue: [^ startingOffset].
	s1 = 0 & (s2 = 0)
		ifTrue: [^ startingOffset].
	_gsSqueakTemp_deltaBig := pt2 - pt1.
	_gsSqueakTemp_colors := {color1. color2}.
	_gsSqueakTemp_segLens := {s1 asFloat. s2 asFloat}.
	_gsSqueakTemp_nextPhase := {2. 1}.
	"Figure out what phase we are in and how far, given startingOffset."
	_gsSqueakTemp_segmentOffset := startingOffset \\ (s1 + s2).
	_gsSqueakTemp_segmentLength := _gsSqueakTemp_segmentOffset < s1
				ifTrue: [_gsSqueakTemp_phase := 1.
					s1 - _gsSqueakTemp_segmentOffset]
				ifFalse: [_gsSqueakTemp_phase := 2.
					s1 + s2 - _gsSqueakTemp_segmentOffset].
	_gsSqueakTemp_startPoint := pt1.
	_gsSqueakTemp_distDone := 0.0.
	[_gsSqueakTemp_distDone < _gsSqueakTemp_dist]
		whileTrue: [_gsSqueakTemp_segmentLength := _gsSqueakTemp_segmentLength min: _gsSqueakTemp_dist - _gsSqueakTemp_distDone.
			_gsSqueakTemp_endPoint := _gsSqueakTemp_startPoint + (_gsSqueakTemp_deltaBig * _gsSqueakTemp_segmentLength / _gsSqueakTemp_dist).
			self
				line: _gsSqueakTemp_startPoint truncated
				to: _gsSqueakTemp_endPoint truncated
				width: width
				color: (_gsSqueakTemp_colors at: _gsSqueakTemp_phase).
			_gsSqueakTemp_distDone := _gsSqueakTemp_distDone + _gsSqueakTemp_segmentLength.
			_gsSqueakTemp_phase := _gsSqueakTemp_nextPhase at: _gsSqueakTemp_phase.
			_gsSqueakTemp_startPoint := _gsSqueakTemp_endPoint.
			_gsSqueakTemp_segmentLength := _gsSqueakTemp_segLens at: _gsSqueakTemp_phase].
	^ startingOffset + _gsSqueakTemp_dist