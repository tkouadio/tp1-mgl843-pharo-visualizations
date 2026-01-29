Class {
	#name : 'TP1ModelGateway',
	#superclass : 'Object',
	#category : 'TP1MGL843-PharoTools',
	#package : 'TP1MGL843-PharoTools'
}

{ #category : 'model-access' }
TP1ModelGateway class >> classes [
    "Retourne les classes du modèle."
    ^ self model allModelClasses
]

{ #category : 'model-access' }
TP1ModelGateway class >> model [
  ^ MooseModel root
      detect: [ :m | (m respondsTo: #name) and: [ m name = 'TP1-MGL843-model' ] ]
      ifNone: [ MooseModel root first ].
]

{ #category : 'model-access' }
TP1ModelGateway class >> tsFiles [
  | m |
  m := self model.
  m ifNil: [ ^ #() ].

  ^ (m respondsTo: #allModelEntities)
      ifTrue: [ m allModelEntities select: [ :e | e className includesSubstring: 'FileAnchor' ] ]
      ifFalse: [ #() ].
]

{ #category : 'model-access' }
TP1ModelGateway class >> tsFunctions [
  | m |
  m := self model.
  m ifNil: [ ^ #() ].

  (m respondsTo: #allModelFunctions) ifTrue: [ ^ m perform: #allModelFunctions ].

  ^ (m respondsTo: #allModelEntities)
      ifTrue: [ m allModelEntities select: [ :e | e className includesSubstring: 'Function' ] ]
      ifFalse: [ #() ].
]

{ #category : 'model-access' }
TP1ModelGateway class >> tsMethods [
  | m |
  m := self model.
  m ifNil: [ ^ #() ].

  (m respondsTo: #allModelMethods) ifTrue: [ ^ m perform: #allModelMethods ].

  ^ (m respondsTo: #allModelEntities)
      ifTrue: [ m allModelEntities select: [ :e | e className includesSubstring: 'Method' ] ]
      ifFalse: [ #() ].
]
