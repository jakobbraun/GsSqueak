update cycle
forceDamageToScreen: allDamage

	"here for the convenience of NebraskaWorldState"
	Display forceDamageToScreen: allDamage.
	self remoteCanvasesDo: [ :each | 
		allDamage do: [:r | each forceToScreen: r].
		each displayIsFullyUpdated.
	].