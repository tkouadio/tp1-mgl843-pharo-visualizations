Class {
	#name : 'TP1PharoToolsTest',
	#superclass : 'TestCase',
	#category : 'TP1MGL843-PharoTools-Tests',
	#package : 'TP1MGL843-PharoTools-Tests'
}

{ #category : 'helpers' }
TP1PharoToolsTest >> hasMooseModel [
    "Retourne vrai si le modèle Moose est chargé."
    ^ MooseModel root notEmpty
        and: [ MooseModel root first notNil ].
]

{ #category : 'tests' }
TP1PharoToolsTest >> testCSVExportCreatesFileAndHeaderOrSkip [
    | fileRef header |
    self hasMooseModel
        ifFalse: [ self skip: 'No Moose model loaded.' ].

    fileRef := FileLocator temp / 'tp1_classes_metrics.csv'.

    TP1CSVExporter exportClassesMetricsToCSVAt: fileRef.

    self assert: fileRef exists.

    header := fileRef readStreamDo: [ :s | s nextLine ].

    self assert: (header includesSubstring: 'className').
    self assert: (header includesSubstring: 'nbAttributes').
    self assert: (header includesSubstring: 'nbMethods').
    self assert: (header includesSubstring: 'loc').

    fileRef ensureDelete.
]

{ #category : 'tests' }
TP1PharoToolsTest >> testGatewayReturnsCollectionsOrSkip [
  | classes functions methods files |

  classes := TP1ModelGateway classes.
  self assert: (classes respondsTo: #do:).

  functions := TP1ModelGateway tsFunctions.
  (functions isNil)
    ifFalse: [ self assert: (functions respondsTo: #do:) ].

  methods := TP1ModelGateway tsMethods.
  (methods isNil)
    ifFalse: [ self assert: (methods respondsTo: #do:) ].

  files := TP1ModelGateway tsFiles.
  (files isNil)
    ifFalse: [ self assert: (files respondsTo: #do:) ].
]

{ #category : 'tests' }
TP1PharoToolsTest >> testModelAccessibleOrSkip [
    self hasMooseModel
        ifFalse: [
            self skip: 'No Moose model loaded. Import the FAMIX TypeScript model first.'
        ].

    self assert: TP1ModelGateway model notNil.
]
