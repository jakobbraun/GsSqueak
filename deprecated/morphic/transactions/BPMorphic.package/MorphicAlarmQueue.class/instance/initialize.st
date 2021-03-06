initialize
initialize
  super initialize.
  mutex := TransientMutex new.
  sequenceNumber := 0.
  heap := Heap
    sortBlock: [ :alarmA :alarmB | 
      alarmA scheduledTime = alarmB scheduledTime
        ifTrue: [ 
          alarmA sequenceNumber = alarmB sequenceNumber
            ifTrue: [ self error: 'These alarms run at the same time' ]
            ifFalse: [ alarmA sequenceNumber < alarmB sequenceNumber ] ]
        ifFalse: [ alarmA scheduledTime < alarmB scheduledTime ] ]