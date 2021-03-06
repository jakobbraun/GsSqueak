*MCEnvSwitch
compile: aClass source: monticelloSource classified: cat withStamp: aString
  | source errString envId |
  source := monticelloSource withGemstoneLineEndings.
  envId := (MCEnv respondsTo: #'current')
    ifTrue: [ MCEnv current ]
    ifFalse: [ 0 ].
  ((MCEnv respondsTo: #'usesSqueakParser') and: [ MCEnv usesSqueakParser ])
    ifTrue: [ 
      aClass newMethodFromSqueakString: source inEnv: MCEnv current classified: cat.
      ^ self ]
    ifFalse: [ 
      aClass
        compileMethod: source
        category: cat
        using: GsSession currentSession symbolList
        environmentId: envId ].
  errString := (Behavior parseSelector: source for: aClass)
    ifNotNil: [ :s | s asSymbol ].
  errString
    ifNil: [ aClass setStamp: aString forMethod: (Behavior parseSelector: source for: aClass) ]
    ifNotNil: [ 
      self gemToolsActive
        ifFalse: [ 
          | str |
          (str := 'ERROR - method compile failed' copy)
            lf;
            add: 'category: ';
            add: $';
            add: cat;
            add: $';
            lf.
          aClass isMeta
            ifTrue: [ str add: 'class' ].
          str
            add: 'method: ';
            add: aClass theNonMetaClass name;
            lf;
            add: errString;
            lf;
            add: '! ----------------- ';
            lf.
          GsFile gciLogClient: str ] ]