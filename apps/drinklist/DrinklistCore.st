'From Squeak6.0alpha of 9 September 2017 [latest update: #17382] on 2 November 2017 at 1:24:22 pm'!
Object subclass: #DrinklistCore
	instanceVariableNames: 'mailClient users inventory transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Drinklist'!

!DrinklistCore methodsFor: 'as yet unclassified' stamp: 'maf 10/26/2017 15:57'!
add: anElement

	anElement addTo: self! !

!DrinklistCore methodsFor: 'as yet unclassified' stamp: 'hpi 11/2/2017 11:28'!
addDrink: aDrink

	inventory at: aDrink label put: aDrink.
	aDrink addDependent: self.
	self flag: #fishy. "remove methods"! !

!DrinklistCore methodsFor: 'as yet unclassified' stamp: 'maf 10/26/2017 15:58'!
addTransaction: aTransaction

	self transactions add: aTransaction! !

!DrinklistCore methodsFor: 'as yet unclassified' stamp: 'WF 11/2/2017 10:05'!
addUser: aUser

	self users at: aUser userName put: aUser! !

!DrinklistCore methodsFor: 'as yet unclassified' stamp: 'hpi 11/2/2017 13:10'!
adminMail
	
	^ 'marc.freiheit@student.hpi.de'! !

!DrinklistCore methodsFor: 'as yet unclassified' stamp: 'hpi 11/2/2017 11:46'!
checkStockOf: aDrink

	aDrink isStockExhaustive
							ifTrue: [ self informAdminAboutLowStock ]! !

!DrinklistCore methodsFor: 'as yet unclassified' stamp: 'hpi 11/2/2017 13:10'!
informAdminAboutLowStock

	self mailClient sendOrderMailTo: self adminMail withStock: self stockList! !

!DrinklistCore methodsFor: 'as yet unclassified' stamp: 'hpi 11/2/2017 13:20'!
informUserAboutHighDebt: anUser

	self mailClient sendRemainderTo: anUser email named: anUser userName forAmount: anUser balance ! !

!DrinklistCore methodsFor: 'as yet unclassified' stamp: 'WF 11/2/2017 09:54'!
initialize 

	self 
		users: Dictionary new;
		inventory: Dictionary new;
		transactions: OrderedCollection new.! !

!DrinklistCore methodsFor: 'as yet unclassified' stamp: 'hpi 11/2/2017 11:49'!
stockList 

	^ self inventory collect: [:drink | drink stock ]! !

!DrinklistCore methodsFor: 'as yet unclassified' stamp: 'WF 11/1/2017 11:18'!
transactionsFor: anUser

	^ self transactions select: [:trans | trans user = anUser ].! !

!DrinklistCore methodsFor: 'as yet unclassified' stamp: 'hpi 11/2/2017 11:41'!
update: anObject
	
	anObject isDrinklistDrink 
							ifTrue: [ self checkStockOf: anObject ]! !


!DrinklistCore methodsFor: 'accessing' stamp: 'WF 11/2/2017 10:28'!
buy: aDrinkLabel by: anUserName
	
	|anUser aDrink transaction|
	
	anUser := self userNamed: anUserName.
	aDrink := self drinkNamed: aDrinkLabel.
	
	(anUser isNil or: aDrink isNil) ifTrue:[^false].
	
	anUser takeDrink: aDrink.
	
	transaction := DrinklistTransaction createFor: anUserName with: aDrink.
	self addTransaction: transaction.
	
	^true! !

!DrinklistCore methodsFor: 'accessing' stamp: 'WF 11/2/2017 10:17'!
drinkNamed: aLabel

	^self inventory at: aLabel.! !

!DrinklistCore methodsFor: 'accessing' stamp: 'WF 10/26/2017 15:49'!
drinks

	^self inventory keys ! !

!DrinklistCore methodsFor: 'accessing' stamp: 'maf 10/26/2017 11:45'!
inventory
	
	^ inventory
! !

!DrinklistCore methodsFor: 'accessing' stamp: 'maf 10/26/2017 11:45'!
inventory: anObject
	
	inventory := anObject.
! !

!DrinklistCore methodsFor: 'accessing' stamp: 'WF 11/2/2017 10:30'!
mailClient
	^ mailClient! !

!DrinklistCore methodsFor: 'accessing' stamp: 'WF 11/2/2017 10:30'!
mailClient: anObject
	mailClient := anObject! !

!DrinklistCore methodsFor: 'accessing' stamp: 'maf 10/26/2017 15:07'!
transactions
	
	^ transactions
! !

!DrinklistCore methodsFor: 'accessing' stamp: 'maf 10/26/2017 15:07'!
transactions: anObject
	
	transactions := anObject.
! !

!DrinklistCore methodsFor: 'accessing' stamp: 'WF 11/1/2017 11:19'!
userNamed: aName

	^self users at: aName.! !

!DrinklistCore methodsFor: 'accessing' stamp: 'maf 10/26/2017 11:45'!
users
	
	^ users
! !

!DrinklistCore methodsFor: 'accessing' stamp: 'WF 11/1/2017 12:19'!
users: aDictionary
	
	users := aDictionary.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

DrinklistCore class
	instanceVariableNames: 'instance'!

!DrinklistCore class methodsFor: 'as yet unclassified' stamp: 'hpi 11/2/2017 11:52'!
instance

  	instance isNil 
				ifTrue: [ self instance: DrinklistCore new ].
					
	^ instance 
	! !

!DrinklistCore class methodsFor: 'as yet unclassified' stamp: 'hpi 11/2/2017 11:53'!
instance: anObject

	 instance := anObject! !

!DrinklistCore class methodsFor: 'as yet unclassified' stamp: 'hpi 11/2/2017 11:13'!
reset

	self instance: DrinklistCore new.
	self seed! !

!DrinklistCore class methodsFor: 'as yet unclassified' stamp: 'hpi 11/2/2017 13:08'!
seed

	self instance 
			add: (DrinklistDrink create: 'Cola' whichCosts: 1 initialStock: 10 minimumStock: 2);
			add: (DrinklistDrink create: 'Bier' whichCosts: 1 initialStock: 10 minimumStock: 2);
			add: (DrinklistDrink create: 'Spritz' whichCosts: 1 initialStock: 10 minimumStock: 2);
			add: (DrinklistDrink create: 'Bauer' whichCosts: 2 initialStock: 10 minimumStock: 2);
			add: (DrinklistDrink create: 'Biobrause' whichCosts: 1 initialStock: 10 minimumStock: 2);
			add: (DrinklistUser create: 'test')! !