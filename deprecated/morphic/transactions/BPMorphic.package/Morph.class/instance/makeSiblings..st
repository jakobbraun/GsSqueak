meta-actions
makeSiblings: count
  "Make multiple sibling, and return the list"

  | listOfNewborns aPosition |
  aPosition := self position.
  listOfNewborns := (1 to: count asInteger) asArray
    collect: [ :anIndex | 
      | anInstance |
      anInstance := self usableSiblingInstance.
      self owner addMorphFront: anInstance.
      aPosition := aPosition + (10 @ 10).
      anInstance position: aPosition.
      anInstance ].
  self currentWorld startSteppingSubmorphsOf: self topRendererOrSelf owner.
  ^ listOfNewborns