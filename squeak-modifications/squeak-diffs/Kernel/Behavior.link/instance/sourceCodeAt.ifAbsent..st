accessing method dictionary
sourceCodeAt: selector ifAbsent: aBlock

	^ (self methodDict at: selector ifAbsent: [^ aBlock value]) getSourceFor: selector in: self
