*Kernel-Processes-process specific
environmentRemoveKey: key
	^ self environmentRemoveKey: key ifAbsent: [self environmentKeyNotFound]
