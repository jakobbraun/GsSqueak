*SqCollectionLiterals-*SqCollectionLiterals-instance creation
integerDictionary
	^ self new hashBlock: [:integer | integer hash \\ 1064164 * 1009]
