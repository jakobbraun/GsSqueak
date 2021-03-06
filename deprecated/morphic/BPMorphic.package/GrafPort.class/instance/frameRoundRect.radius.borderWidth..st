drawing support
frameRoundRect: aRectangle radius: radius borderWidth: borderWidth 
	| nextY outer nextOuterX ovalDiameter rectExtent rectOffset rectX rectY rectWidth rectHeight ovalRadius ovalRect innerRadius innerDiameter innerRect inner nextInnerX wp |
	aRectangle area <= 0
		ifTrue: [^ self].
	ovalDiameter := (radius * 2) asPoint min: aRectangle extent.
	(ovalDiameter x <= 0
			or: [ovalDiameter y <= 0])
		ifTrue: [^ self fillRect: aRectangle offset: 0 @ 0].
	"force diameter to be even - this simplifies lots of stuff"
	ovalRadius := ovalDiameter x // 2 @ (ovalDiameter y // 2).
	(ovalRadius x <= 0
			or: [ovalRadius y <= 0])
		ifTrue: [^ self fillRect: aRectangle offset: 0 @ 0].
	wp := borderWidth asPoint.
	ovalDiameter := ovalRadius * 2.
	innerRadius := ovalRadius - borderWidth max: 0 @ 0.
	innerDiameter := innerRadius * 2.
	rectExtent := aRectangle extent - ovalDiameter.
	rectWidth := rectExtent x.
	rectHeight := rectExtent y.
	rectOffset := aRectangle origin + ovalRadius.
	rectX := rectOffset x.
	rectY := rectOffset y.
	ovalRect := 0 @ 0 extent: ovalDiameter.
	innerRect := 0 @ 0 extent: innerDiameter.
	height := 1.
	outer := EllipseMidpointTracer new on: ovalRect.
	inner := EllipseMidpointTracer new on: innerRect.
	nextY := ovalRadius y.
	1
		to: (wp y min: nextY)
		do: [:i | 
			nextOuterX := outer stepInY.
			width := nextOuterX * 2 + rectWidth.
			destX := rectX - nextOuterX.
			destY := rectY - nextY.
			self copyBits.
			destY := rectY + nextY + rectHeight - 1.
			self copyBits.
			nextY := nextY - 1].
	[nextY > 0]
		whileTrue: [nextOuterX := outer stepInY.
			nextInnerX := inner stepInY.
			destX := rectX - nextOuterX.
			destY := rectY - nextY.
			width := nextOuterX - nextInnerX.
			self copyBits.
			destX := rectX + nextInnerX + rectWidth.
			self copyBits.
			destX := rectX - nextOuterX.
			destY := rectY + nextY + rectHeight - 1.
			self copyBits.
			destX := rectX + nextInnerX + rectWidth.
			self copyBits.
			nextY := nextY - 1].
	destX := aRectangle left.
	destY := rectOffset y.
	height := rectHeight.
	width := wp x.
	self copyBits.
	destX := aRectangle right - width.
	self copyBits.
	innerRadius y = 0
		ifTrue: [destX := aRectangle left + wp x.
			destY := rectY.
			width := rectWidth.
			height := wp y - ovalRadius y.
			self copyBits.
			destY := aRectangle bottom - wp y.
			self copyBits]