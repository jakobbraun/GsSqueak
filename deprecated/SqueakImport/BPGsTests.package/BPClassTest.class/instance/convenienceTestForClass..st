as yet unclassified
convenienceTestForClass: aClass
    self assert: aClass isNil not.
  self assert: aClass @env7: name equals: #'SubclassName'.
  self assert: aClass category equals: 'myCat'.