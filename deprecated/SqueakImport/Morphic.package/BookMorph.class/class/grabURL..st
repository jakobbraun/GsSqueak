url
grabURL: aURLString
	"Create a BookMorph for this url and put it in the hand."

	| book |
	book := self new fromURL: aURLString.
	"If this book is already in, we will steal the pages out of it!!!!"
	book goToPage: 1.	"install it"
	HandMorph attach: book