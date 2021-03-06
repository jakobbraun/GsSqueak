oop comparison
oop: anOop isGreaterThan: baseOop andLessThan: limitOop 
	"Compare two oop values, treating them as object memory locations;
	i.e. use unsigned comparisons.
	Use a macro, instead of #cCoerce:to: to provide fast simulation and
	inline code in conditionals,
	since the inliner doesn't inline in condtionals."
	^ anOop > baseOop
		and: [anOop < limitOop]