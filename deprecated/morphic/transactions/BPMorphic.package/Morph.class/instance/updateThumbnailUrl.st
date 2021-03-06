thumbnail
updateThumbnailUrl
  "If I have a cached thumbnail, then update it's urls."

  (self valueOfProperty: #'cachedThumbnail')
    ifNotNil: [ :cachedThumbnail | 
      (cachedThumbnail respondsTo: #'computeThumbnail')
        ifTrue: [ cachedThumbnail pageMorph: self url inBook: self owner url ]
        ifFalse: [ self removeProperty: #'computeThumbnail' ] ]