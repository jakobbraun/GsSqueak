accessing method dictionary
allSelectors
    "Answer all selectors understood by instances of the receiver"

    ^(Array streamContents: [ :stream |
        self withAllSuperclassesDo: [ :aClass |
            aClass selectorsDo: [ :each | 
                stream nextPut: each ] ] ]) asIdentitySet
