*SqClasses-debugging-haltOnce
doExpiredInspectCount
	self clearHaltOnce.
	self removeHaltCount.
	self inspect
