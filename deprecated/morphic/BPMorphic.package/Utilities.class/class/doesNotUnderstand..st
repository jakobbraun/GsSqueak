debugging
doesNotUnderstand: aMessage 
	"A temporary expedient for revectoring various messages formerly sent
	to Utilities that now are instead implemented by Flaps; this is only for
	the benefit of pre-existing buttons and menu items that were set up
	to call the old interface"
	| _gsSqueakTemp_aSelector |
	_gsSqueakTemp_aSelector := aMessage selector.
	(#(#addLocalFlap #explainFlaps #addMenuFlap #addPaintingFlap #addStackToolsFlap #addGlobalFlap #offerGlobalFlapsMenu #toggleWhetherToUseGlobalFlaps ) includes: _gsSqueakTemp_aSelector)
		ifTrue: [^ self inform: 'Sorry, this is an obsolete menu.  Please
dismiss it and get a fresh one.  Thank you'].
	^ super doesNotUnderstand: aMessage