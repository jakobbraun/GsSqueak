*SqKernel-evaluating
value: firstObject value: secondObject value: thirdObject
  "Return the value of the receiver evaluated with the three objects as its
 arguments.  If the block expects a different number of arguments, an error is
 generated.

 #value:value:value: is optimized by the compiler.
 This method is in the image for use by perform: and for
 failure paths from the optimized bytecode "
  self numArgs ~= 3 ifTrue:
	[self numArgsError: 3].
  ^ self
    valueWithArguments:
      {firstObject.
      secondObject.
      thirdObject}
