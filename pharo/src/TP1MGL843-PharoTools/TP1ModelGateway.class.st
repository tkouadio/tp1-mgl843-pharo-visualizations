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
    "Retourne le modèle Moose/FAMIX chargé dans l'image."
    ^ MooseModel root first
]

{ #category : 'model-access' }
TP1ModelGateway class >> tsFiles [
    | m |
    m := self model.
    (m respondsTo: #allFiles) ifTrue: [ ^ m perform: #allFiles ].
    (m respondsTo: #allSourceFiles) ifTrue: [ ^ m perform: #allSourceFiles ].
    (m respondsTo: #allModelFiles) ifTrue: [ ^ m perform: #allModelFiles ].
    ^ #()
]

{ #category : 'model-access' }
TP1ModelGateway class >> tsFunctions [
    | m |
    m := self model.
    (m respondsTo: #allModelFunctions) ifTrue: [ ^ m perform: #allModelFunctions ].
    (m respondsTo: #allFunctions) ifTrue: [ ^ m perform: #allFunctions ].
    ^ #()
]

{ #category : 'model-access' }
TP1ModelGateway class >> tsMethods [
    | m |
    m := self model.

    (m respondsTo: #allModelMethods) ifTrue: [ ^ m perform: #allModelMethods ].
    (m respondsTo: #allMethods) ifTrue: [ ^ m perform: #allMethods ].

    ^ (self classes flatCollect: [ :c |
        (c respondsTo: #methods) ifTrue: [ c methods ]
        ifFalse: [
            (c respondsTo: #localMethods) ifTrue: [ c localMethods ] ifFalse: [ #() ]
        ]
    ])
]
