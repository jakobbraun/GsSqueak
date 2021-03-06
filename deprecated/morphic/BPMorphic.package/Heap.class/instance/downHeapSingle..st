private-heap
downHeapSingle: anIndex 
	"This version is optimized for the case when only one element in the
	receiver can be at a wrong position. It avoids one comparison at each
	node when travelling down the heap and checks the heap upwards
	after the element is at a bottom position. Since the probability for
	being at the bottom of the heap is much larger than for being
	somewhere in the middle this version should be faster."
	| childIndex index value |
	index := anIndex.
	value := array at: anIndex.
	[(childIndex := 2 * index) < tally]
		whileTrue: ["Select the child with the larger value. We know there are two
			children. "
			(sortBlock
					ifNil: [(array at: childIndex + 1)
							<= (array at: childIndex)]
					ifNotNil: [sortBlock
							value: (array at: childIndex + 1)
							value: (array at: childIndex)])
				ifTrue: [childIndex := childIndex + 1].
			array
				at: index
				put: (array at: childIndex).
			indexUpdateBlock
				ifNotNil: [indexUpdateBlock
						value: (array at: index)
						value: index].
			"and repeat at the next level"
			index := childIndex].
	childIndex = tally
		ifTrue: ["Child with no sibling"
			array
				at: index
				put: (array at: childIndex).
			indexUpdateBlock
				ifNotNil: [indexUpdateBlock
						value: (array at: index)
						value: index].
			index := childIndex].
	array at: index put: value.
	indexUpdateBlock
		ifNotNil: [indexUpdateBlock value: value value: index].
	self upHeap: index