subclass creation
asArrayParam: aString
  ^ (aString splitBy: ' ') select: [ :each | each isEmpty not ] 
