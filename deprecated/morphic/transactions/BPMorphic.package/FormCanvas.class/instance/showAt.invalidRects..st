other
showAt: pt invalidRects: updateRects 
	| _gsSqueakTemp_blt |
	_gsSqueakTemp_blt := (BitBlt toForm: Display) sourceForm: form;
				 combinationRule: Form over.
	updateRects
		do: [:rect | _gsSqueakTemp_blt sourceRect: rect;
				 destOrigin: rect topLeft + pt;
				 copyBits]