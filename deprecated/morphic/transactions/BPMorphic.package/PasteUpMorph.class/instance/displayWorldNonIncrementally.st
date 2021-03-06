world state
displayWorldNonIncrementally
	"Display the morph world non-incrementally. Used for testing."
	(worldState canvas isNil
			or: [worldState canvas extent ~= self viewBox extent
					or: [worldState canvas form depth ~= Display depth]])
		ifTrue: ["allocate a new offscreen canvas the size of the window"
			worldState
				canvas: (Display defaultCanvasClass extent: self viewBox extent)].
	worldState canvas fillColor: color.
	submorphs
		reverseDo: [:m | worldState canvas fullDrawMorph: m].
	worldState
		handsReverseDo: [:h | worldState canvas fullDrawMorph: h].
	worldState canvas form displayOn: Display at: self viewBox origin.
	self fullRepaintNeeded.
	"don't collect damage"
	Display forceDisplayUpdate