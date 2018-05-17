evaluating
applyTo: args inLisp: aLisp withEnvironment: env
  " this is the core place for function application in LispKit

	args is a ConsCell providing the procedure arguments 
	mflag when true forces the arguments to be kept unevaluated
		just as they would for a macro invocation (while a false 
		value does not mean macro arguments are evaluated btw)
	env provides the environment for the procedure body
"

  | sublisp val body arguments |
  body := cdr cdr.
  sublisp := aLisp
    subLisp: car
    form: self
    body: body
    environment: env newChild.	"evaluating (or not) the arguments"
  arguments := aLisp evalList: args.
  body ifNil: [ ^ nil ].
  (self lambdaFormBindingsWith: arguments)
    do: [ :binding | 
      aLisp checkSymbol: binding key.
      sublisp symbolValuesAdd: binding ].
  body
    doWithCdr: [ :form :formcdr | 
      formcdr
        ifNotNil: [ sublisp evalObject: form ]
        ifNil: [ val := sublisp evalTailObject: form ] ].
  ^ val