stepping and presenter
isStepping
	"Return true if the receiver is currently stepping in its world"
	^ self world
		ifNil: [false]
		ifNotNil: [:aWorld | aWorld isStepping: self]