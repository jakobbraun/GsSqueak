translating
changesEnvironment
  (self selector startsWith: '_env')
    ifTrue: [ ^ self selector key last asDigit ]
    ifFalse: [ 
      self arguments
        ifNotEmpty: [ :args | 
          (args last isKindOf: SqMessageNode)
            ifTrue: [ ^ args last changesEnvironment ] ] ].
  ^ false