testing
isAbstract
	"Answer true if I am to be considered an abstract class.
	An abstract class shall better not be instantiated.
	Or its instances may miss some important behavior.
	Typically, a class with methods sending #subclassResponsibility might be considered abstract.
	But we can't erect this as a general rule, it might be that the message is never sent.
	By default, all classes are concrete, up to each one to declare itself abstract."
	
	^false
