menus
addPaintingItemsTo: aMenu hand: aHandMorph 
	| subMenu movies |
	subMenu := MenuMorph new defaultTarget: self.
	subMenu
		add: 'repaint' translated action: #editDrawing;
		add: 'set rotation center' translated action: #setRotationCenter;
		add: 'reset forward-direction' translated action: #resetForwardDirection;
		add: 'set rotation style' translated action: #setRotationStyle;
		add: 'erase pixels of color' translated action: #erasePixelsUsing:;
		add: 'recolor pixels of color' translated action: #recolorPixelsUsing:;
		add: 'reduce color palette' translated action: #reduceColorPalette:;
		add: 'detect edges' translated action: #edgeDetect;
		add: 'sharpen' translated action: #sharpen;
		add: 'blur' translated action: #blur;
		add: 'emboss' translated action: #emboss;
		add: 'add a border around this shape...' translated action: #addBorderToShape:.
	movies := (self world rootMorphsAt: aHandMorph targetPoint) 
				select: [:m | (m isKindOf: MovieMorph) or: [m isSketchMorph]].
	movies size > 1 
		ifTrue: 
			[subMenu add: 'insert into movie' translated action: #insertIntoMovie:].
	aMenu add: 'painting...' translated subMenu: subMenu