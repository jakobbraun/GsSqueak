menu & halo
addPlayfieldMenuItems: menu hand: aHandMorph 
	"Add playfield-related items to the menu"
	menu
		add: 'playfield options...' translated
		target: self
		action: #presentPlayfieldMenu.
	(self hasProperty: #donorTextMorph)
		ifTrue: [menu add: 'send contents back to donor' translated action: #sendTextContentsBackToDonor]