converting
compressWithTable: tokens
	"Return a string with all substrings that occur in tokens replaced
	by a character with ascii code = 127 + token index.
	This will work best if tokens are sorted by size.
	Assumes this string contains no characters > 127, or that they
	are intentionally there and will not interfere with this process."
	| str null finalSize result ri c |
	null := Character null.
	str := self copyFrom: 1 to: self size.  "Working string will get altered"
	finalSize := str size.
	tokens doWithIndex:
		[:token :tIndex |
		| start ts |
		start := 1.
		[(start := str findString: token startingAt: start) > 0]
			whileTrue:
			[ts := token size.
			((start + ts) <= str size
				and: [(str at: start + ts) = $  and: [tIndex*2 <= 128]])
				ifTrue: [ts := token size + 1.  "include training blank"
						str at: start put: (Character value: tIndex*2 + 127)]
				ifFalse: [str at: start put: (Character value: tIndex + 127)].
			str at: start put: (Character value: tIndex + 127).
			1 to: ts-1 do: [:i | str at: start+i put: null].
			finalSize := finalSize - (ts - 1).
			start := start + ts]].
	result := String new: finalSize.
	ri := 0.
	1 to: str size do:
		[:i | (c := str at: i) = null ifFalse: [result at: (ri := ri+1) put: c]].
	^ result
