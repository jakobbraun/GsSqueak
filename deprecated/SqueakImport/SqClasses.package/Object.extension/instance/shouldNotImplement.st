*SqClasses-error handling
shouldNotImplement
	"Announce that, although the receiver inherits this message, it should 
	not implement it."

	NotImplemented signal: ('{1} is not a message appropriate for a {2}' format: {thisContext sender selector. self className}).
