flaps
removeAccommodationForFlap: aFlapTab 
	"Shift submorphs over, if appropriate"
	| offset |
	aFlapTab slidesOtherObjects
		ifTrue: [offset := self offsetForAccommodating: aFlapTab referent extent onEdge: aFlapTab edgeToAdhereTo.
			self shiftSubmorphsBy: offset negated]