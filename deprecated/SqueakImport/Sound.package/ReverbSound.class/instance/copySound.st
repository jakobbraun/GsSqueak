copying
copySound
	"Private! Support for copying. Copy my component sound."

	sound := sound copy.
	leftBuffer := leftBuffer shallowCopy.
	rightBuffer := rightBuffer shallowCopy.
