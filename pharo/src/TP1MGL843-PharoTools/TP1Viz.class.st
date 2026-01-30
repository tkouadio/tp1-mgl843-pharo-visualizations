Class {
	#name : 'TP1Viz',
	#superclass : 'Object',
	#category : 'TP1MGL843-PharoTools',
	#package : 'TP1MGL843-PharoTools'
}

{ #category : 'visualization' }
TP1Viz class >> makeShapeClickable: aShape [

	aShape
		when: RSMouseClick
		do: [ :evt | self openEntity: aShape model ]
		for: self;
		when: RSMouseEnter do: [ :evt |
			aShape border: (RSBorder new
						 width: 2;
						 color: Color blue) ]
		for: self;
		when: RSMouseLeave do: [ :evt | aShape border: nil ] for: self
]

{ #category : 'visualization' }
TP1Viz class >> openClassesMap [
    | classes c |
    classes := TP1ModelGateway classes.
    classes ifEmpty: [ ^ self inform: 'Aucune classe trouvée dans le modèle (as-tu bien chargé le modèle FAMIX TS ?)' ].

    c := RSCanvas new.
    classes do: [ :aClass |
        | box |
        box := RSBox new model: aClass.
        self makeShapeClickable: box.
        c add: box
    ].

    (classes anySatisfy: [ :cl | cl respondsTo: #numberOfAttributes ]) ifTrue: [
        RSNormalizer width shapes: c shapes; from: 6; to: 20; normalize: #numberOfAttributes
    ].
    (classes anySatisfy: [ :cl | cl respondsTo: #numberOfMethods ]) ifTrue: [
        RSNormalizer height shapes: c shapes; normalize: #numberOfMethods
    ].
    (classes anySatisfy: [ :cl | cl respondsTo: #numberOfLinesOfCode ]) ifTrue: [
        RSNormalizer color shapes: c shapes; from: Color gray; to: Color red; normalize: #numberOfLinesOfCode
    ].

    RSTreeLayout on: c nodes.
    c nodes @ RSDraggable @ RSPopup.
    c @ RSCanvasController.
    c open.

]

{ #category : 'visualization' }
TP1Viz class >> openEntity: anEntity [
    "Ouvre l'entité FAMIX dans MooseInspector si dispo, sinon inspect."
    | mi |
    mi := Smalltalk at: #MooseInspector ifAbsent: [ nil ].
    mi
        ifNil: [ anEntity inspect ]
        ifNotNil: [ mi openOn: anEntity ].
]

{ #category : 'visualization' }
TP1Viz class >> openFilesMap [
    | model files c |
    model := TP1ModelGateway model.
    files := model allModelEntities select: [ :e | e className includesSubstring: 'FileAnchor' ].
    files ifEmpty: [ ^ self inform: 'Aucun FileAnchor trouvé dans le modèle.' ].

    c := RSCanvas new.
    files do: [ :f |
        | box |
        box := RSBox new model: f.
        self makeShapeClickable: box.
        c add: box
    ].

    (files anySatisfy: [ :f | (f respondsTo: #startLine) and: [ f respondsTo: #endLine ] ]) ifTrue: [
        RSNormalizer width shapes: c shapes; from: 10; to: 60;
            normalize: [ :fa | (fa endLine - fa startLine) max: 1 ].
        RSNormalizer height shapes: c shapes;
            normalize: [ :fa | (fa endLine - fa startLine) max: 1 ].
        RSNormalizer color shapes: c shapes;
            from: Color gray; to: Color red;
            normalize: [ :fa | (fa endLine - fa startLine) max: 1 ].
    ].

    RSGridLayout on: c nodes.
    c nodes @ RSDraggable @ RSPopup.
    c @ RSCanvasController.
    c open.

]

{ #category : 'visualization' }
TP1Viz class >> openFunctionsMap [
    | model functions c |
    model := TP1ModelGateway model.

    functions := (model respondsTo: #allModelFunctions)
        ifTrue: [ model perform: #allModelFunctions ]
        ifFalse: [ model allModelEntities select: [ :e | e className includesSubstring: 'Function' ] ].

    functions ifEmpty: [ ^ self inform: 'Aucune fonction trouvée dans le modèle.' ].

    c := RSCanvas new.
    functions do: [ :f |
        | box |
        box := RSBox new model: f.
        self makeShapeClickable: box.
        c add: box
    ].

    (functions anySatisfy: [ :f | f respondsTo: #cyclomaticComplexity ])
        ifTrue: [ RSNormalizer width shapes: c shapes; from: 6; to: 20; normalize: #cyclomaticComplexity ]
        ifFalse: [
            (functions anySatisfy: [ :f | f respondsTo: #numberOfStatements ])
                ifTrue: [ RSNormalizer width shapes: c shapes; from: 6; to: 20; normalize: #numberOfStatements ].
        ].

    (functions anySatisfy: [ :f | f respondsTo: #numberOfLinesOfCode ]) ifTrue: [
        RSNormalizer height shapes: c shapes; normalize: #numberOfLinesOfCode.
        RSNormalizer color shapes: c shapes; from: Color gray; to: Color red; normalize: #numberOfLinesOfCode
    ].

    RSGridLayout on: c nodes.
    c nodes @ RSDraggable @ RSPopup.
    c @ RSCanvasController.
    c open.

]

{ #category : 'visualization' }
TP1Viz class >> openMethodsMap [
    | model methods c |
    model := TP1ModelGateway model.

    methods := (model respondsTo: #allModelMethods)
        ifTrue: [ model perform: #allModelMethods ]
        ifFalse: [ model allModelEntities select: [ :e | e className includesSubstring: 'Method' ] ].

    methods ifEmpty: [ ^ self inform: 'Aucune méthode trouvée dans le modèle.' ].

    c := RSCanvas new.
    methods do: [ :m |
        | box |
        box := RSBox new model: m.
        self makeShapeClickable: box.
        c add: box
    ].

    (methods anySatisfy: [ :m | m respondsTo: #numberOfStatements ]) ifTrue: [
        RSNormalizer width shapes: c shapes; from: 6; to: 20; normalize: #numberOfStatements
    ].

    (methods anySatisfy: [ :m | m respondsTo: #numberOfLinesOfCode ]) ifTrue: [
        RSNormalizer height shapes: c shapes; normalize: #numberOfLinesOfCode.
        RSNormalizer color shapes: c shapes; from: Color gray; to: Color red; normalize: #numberOfLinesOfCode
    ].

    RSGridLayout on: c nodes.
    c nodes @ RSDraggable @ RSPopup.
    c @ RSCanvasController.
    c open.

]
