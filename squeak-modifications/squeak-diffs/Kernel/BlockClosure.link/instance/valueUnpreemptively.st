private
valueUnpreemptively
	"Evaluate the receiver (block), without the possibility of preemption by higher priority processes. Use this facility VERY sparingly!"
	"Think about using Block>>valueUninterruptably first, and think about using Semaphore>>critical: before that, and think about redesigning your application even before that! 
	After you've done all that thinking, go right ahead and use it..."
	| activeProcess oldPriority result |
	activeProcess := Processor activeProcess.
	oldPriority := activeProcess priority.
	activeProcess priority: Processor highestPriority.
	result := self ensure: [activeProcess priority: oldPriority].
	"Yield after restoring priority to give the preempted processes a chance to run"
	Processor yield.
	^result

