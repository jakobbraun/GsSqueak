initialization
finish: allDamage 
	"If there are any pending operations on the receiver complete them. 
	Do not return before all modifications have taken effect."
	^ self finish