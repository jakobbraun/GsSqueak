*BPToolsTode
fileInInEnv: envId
  | val |
  [ self atEnd ]
    whileFalse: [ 
      self skipSeparators.
      val := (self peekFor: $!)
        ifTrue: [ 
          | chunk classReader |
          chunk := self nextChunk.
          classReader := chunk evaluateInEnv: envId.
          classReader scanFrom: self inEnv: envId ]
        ifFalse: [ self nextChunk evaluateInEnv: envId ] ].
  ^ val