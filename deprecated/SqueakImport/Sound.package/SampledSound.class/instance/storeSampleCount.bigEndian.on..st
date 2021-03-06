file i/o
storeSampleCount: samplesToStore bigEndian: bigEndianFlag on: aBinaryStream
	"Store my samples on the given stream at the current SoundPlayer sampling rate. If bigFlag is true, then each 16-bit sample is stored most-significant byte first (AIFF files), otherwise it is stored least-significant byte first (WAV files)."

	| reverseBytes |
	self samplingRate ~= originalSamplingRate ifTrue: [
		^ super storeSampleCount: samplesToStore bigEndian: bigEndianFlag on: aBinaryStream].

	"optimization: if sampling rates match, just store my buffer"
	reverseBytes := bigEndianFlag ~= Smalltalk isBigEndian.
	reverseBytes ifTrue: [samples reverseEndianness].
	(aBinaryStream isKindOf: StandardFileStream)
		ifTrue: [  "optimization for files: write sound buffer directly to file"
			aBinaryStream next: (samples size // 2) putAll: samples startingAt: 1]  "size in words"
		ifFalse: [  "for non-file streams:"
			1 to: samples monoSampleCount do: [:i | aBinaryStream int16: (samples at: i)]].
	reverseBytes ifTrue: [samples reverseEndianness].  "restore to original endianness"
