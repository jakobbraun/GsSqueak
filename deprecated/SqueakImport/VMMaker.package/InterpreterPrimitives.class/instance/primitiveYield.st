process primitives
primitiveYield
"primitively do the equivalent of Process>yield"
	| activeProc priority processLists processList |
	activeProc := objectMemory fetchPointer: ActiveProcessIndex
						 ofObject: self schedulerPointer.
	priority := self quickFetchInteger: PriorityIndex ofObject: activeProc.
	processLists := objectMemory fetchPointer: ProcessListsIndex ofObject: self schedulerPointer.
	processList := objectMemory fetchPointer: priority - 1 ofObject: processLists.

	(self isEmptyList: processList) ifFalse:[
		self addLastLink: activeProc toList: processList.
		self transferTo: self wakeHighestPriority]