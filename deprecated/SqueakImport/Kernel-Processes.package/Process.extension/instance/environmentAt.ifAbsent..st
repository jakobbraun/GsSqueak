*Kernel-Processes-process specific
environmentAt: key  ifAbsent: aBlock
	"GsSqueak does not support having more than one Environment"
	^ Smalltalk globals at: key ifAbsent: aBlock.
