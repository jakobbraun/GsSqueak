arithmetic
- aNumber
  <primitive: 259>
  
aNumber isFraction ifTrue:
    [^Fraction numerator: self * aNumber denominator - aNumber numerator denominator: aNumber denominator].
^ aNumber adaptToInteger: self andSend: #-
