*SqClasses-tracing
outboundPointersDo: aBlock
"do aBlock for every object I point to, exactly how the garbage collector would. Adapted from PointerFinder >> #followObject:"

	aBlock value: self class.
	1 to: self class instSize do: [:i | aBlock value: (self instVarAt: i)].
	1 to: self basicSize do: [:i | aBlock value: (self basicAt: i)].
