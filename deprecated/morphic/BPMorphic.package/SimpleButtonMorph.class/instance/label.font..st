accessing
label: aString font: aFont 
	| _gsSqueakTemp_m |
	(self findA: StringMorph)
		ifNotNil: [:_gsSqueakTemp_oldLabel | _gsSqueakTemp_oldLabel delete].
	_gsSqueakTemp_m := StringMorph
				contents: aString
				font: (aFont
						ifNil: [Preferences standardButtonFont]).
	self extent: _gsSqueakTemp_m width + 6 @ (_gsSqueakTemp_m height + 6).
	_gsSqueakTemp_m position: self center - (_gsSqueakTemp_m extent // 2).
	self addMorph: _gsSqueakTemp_m.
	_gsSqueakTemp_m lock