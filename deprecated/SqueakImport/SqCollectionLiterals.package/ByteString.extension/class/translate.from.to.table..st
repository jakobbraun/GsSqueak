*SqCollectionLiterals-*SqCollectionLiterals-primitives
translate: aString from: start  to: stop  table: table
	"translate the characters in the string by the given table, in place"
	
	start to: stop do: [ :i |
		aString at: i put: (table at: (aString basicAt: i) + 1) ]
