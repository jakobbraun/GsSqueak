*SqClasses-system primitives
instVarAt: index
	"Primitive. Answer a fixed variable in an object. The numbering of the variables
	 corresponds to the named instance variables, followed by the indexed instance
	 variables. Fail if the index is not an Integer or is not the index of a fixed or
	 indexed variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 611> "Gemstone primitive"
	self primitiveFailed
