menus
addWorldTargetSightingItems: aCustomMenu hand: aHandMorph 
	"Use cursor to select a point on screen.
	Set target from all possible morphs under cursor sight."
	aCustomMenu addLine.
	aCustomMenu add: 'sight target' translated action: #sightWorldTargets: