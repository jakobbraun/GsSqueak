misc
stepAll
	"tick all the paused player scripts in the receiver"

	self presenter allExtantPlayers do:
		[:aPlayer | 
			aPlayer startRunning; step; stopRunning]