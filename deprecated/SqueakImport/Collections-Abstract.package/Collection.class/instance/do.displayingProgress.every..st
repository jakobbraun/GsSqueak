enumerating
do: aBlock displayingProgress: aStringOrBlock every: msecs
	"Enumerate aBlock displaying progress information. 
	If the argument is a string, use a static label for the process. 
	If the argument is a block, evaluate it with the element to retrieve the label.
	The msecs argument ensures that updates happen at most every msecs.
	Example:
		Smalltalk allClasses 
			do:[:aClass| (Delay forMilliseconds: 1) wait]
			displayingProgress:[:aClass| 'Processing ', aClass name]
			every: 0.
		Smalltalk allClasses 
			do:[:aClass| (Delay forMilliseconds: 1) wait]
			displayingProgress:[:aClass| 'Processing ', aClass name]
			every: 100.
	"
	| size labelBlock count oldLabel lastUpdate |
	labelBlock := aStringOrBlock isString 
		ifTrue:[[:item| aStringOrBlock]] 
		ifFalse:[aStringOrBlock].
	oldLabel := nil.
	count := lastUpdate := 0.
	size := self size.
	'' displayProgressFrom: 0 to: size during:[:bar |
		self do:[:each| | newLabel |
			"Special handling for first and last element"
			(count = 0 or:[count+1 = size 
				or:[(Time millisecondsSince: lastUpdate) >= msecs]]) ifTrue:[
					bar value: count.
					oldLabel = (newLabel := (labelBlock value: each) ifNil:[oldLabel]) ifFalse:[
					ProgressNotification signal: '' extra: (oldLabel := newLabel).
				].
				lastUpdate := Time millisecondClockValue.
			].
			aBlock value: each.
			count := count + 1.
	]]