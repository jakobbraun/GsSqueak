balloon drawing
drawBezierShape: vertices color: c borderWidth: borderWidth borderColor: borderColor 
	"Draw a boundary shape that is defined by a list of vertices.
	Each three subsequent vertices define a quadratic bezier segment.
	For lines, the control point should be set to either the start or the end
	of the bezier curve."
	| _gsSqueakTemp_fillC _gsSqueakTemp_borderC |
	_gsSqueakTemp_fillC := self shadowColor
				ifNil: [c].
	_gsSqueakTemp_borderC := self shadowColor
				ifNil: [borderColor].
	self ensuredEngine
		drawBezierShape: vertices
		fill: _gsSqueakTemp_fillC
		borderWidth: borderWidth
		borderColor: _gsSqueakTemp_borderC
		transform: transform