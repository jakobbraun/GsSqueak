initialize
loadStackFrom: aContext
  self push: (aContext at: 10).	"reciever"
  method := aContext at: 1.	"method"
  argumentCount := method numArgs.
  1 to: argumentCount do: [ :i | self push: (aContext at: i) ]