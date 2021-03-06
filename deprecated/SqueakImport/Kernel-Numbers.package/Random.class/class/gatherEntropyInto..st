entropy source
gatherEntropyInto: aByteArray
	"Gather good random entropy from a system source and fill up aByteArray with it. Return true upon success, else false."
	
	| generator |
	generator := (GemstoneSmalltalk _env0 at: #HostRandom) _env0 new _env0 file.
	1 to: aByteArray size do: [:i |
		aByteArray at: i put: generator _env0 nextByte].
	^ true
