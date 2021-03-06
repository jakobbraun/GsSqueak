*BPMorphic
isDefined: directiveString inSmalltalk: conditionBlock comment: commentStringOrNil ifTrue: trueExpressionOrBlock
  "When translated, produces #ifdef #endif CPP directives.
	Example usage:

	self isDefined: 'HAVE_FOO'
		inSmalltalk: [self isFoo]
		comment: 'some platforms do not support foo properly'
		ifTrue: [self doThingsThatWorkIfFooIsPresent]

	Generated C code:
	
	# ifdef HAVE_FOO  // some platforms do not support foo properly
 		doThingsThatWorkIfFooIsPresent();
	# endif  // HAVE_FOO
	"

  ^ self
    isDefined: directiveString
    inSmalltalk: conditionBlock
    comment: commentStringOrNil
    ifTrue: trueExpressionOrBlock
    ifFalse: [  ]