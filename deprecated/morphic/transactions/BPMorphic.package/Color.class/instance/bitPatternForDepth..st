conversions
bitPatternForDepth: depth
  "Return a Bitmap, possibly containing a stipple pattern, that best
	represents this color at the given depth. BitBlt calls this method to
	convert colors into Bitmaps. The resulting Bitmap may be multiple
	words to represent a stipple pattern of several lines. "

  "See also:	pixelValueAtDepth:	-- value for single pixel
	pixelWordAtDepth:	-- a 32-bit word filled with the pixel value"

  "Details: The pattern for the most recently requested depth is cached."

  "Note for depths > 2, there are stippled and non-stippled versions
	(generated with #balancedPatternForDepth: and
	#bitPatternForDepth:, respectively). The stippled versions don't work
	with the window bit caching of StandardSystemView, so we make
	sure that for these depths, only unstippled patterns are returned"

  "(depth == cachedDepth and: [ depth <= 2 or: [ cachedBitPattern size = 1 ] ])
    ifTrue: [ ^ cachedBitPattern ]."

  "TODO hack"

  self bitPatternCache cachedDepth: depth.
  depth > 2
    ifTrue: [ 
      self bitPatternCache
        cachedBitPattern: (Bitmap with: (self pixelWordForDepth: depth)).
      ^ self bitPatternCache cachedBitPattern ].
  depth = 1
    ifTrue: [ 
      self bitPatternCache cachedBitPattern: self halfTonePattern1.
      ^ self bitPatternCache cachedBitPattern ].
  depth = 2
    ifTrue: [ 
      self bitPatternCache cachedBitPattern: self halfTonePattern2.
      ^ self bitPatternCache cachedBitPattern ]