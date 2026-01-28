Class {
	#name : 'TP1CSVExporter',
	#superclass : 'Object',
	#category : 'TP1MGL843-PharoTools',
	#package : 'TP1MGL843-PharoTools'
}

{ #category : 'exporting' }
TP1CSVExporter class >> classMetricsRows [
    ^ TP1ModelGateway classes collect: [ :c |
        | className attrs meths loc |
        className := (c respondsTo: #name) ifTrue: [ c name ] ifFalse: [ c asString ].
        attrs := (c respondsTo: #numberOfAttributes) ifTrue: [ c numberOfAttributes ] ifFalse: [ 0 ].
        meths := (c respondsTo: #numberOfMethods) ifTrue: [ c numberOfMethods ] ifFalse: [ 0 ].
        loc := (c respondsTo: #numberOfLinesOfCode) ifTrue: [ c numberOfLinesOfCode ] ifFalse: [ 0 ].
        { className. attrs. meths. loc }
    ].
]

{ #category : 'exporting' }
TP1CSVExporter class >> exportClassesMetricsToCSVAt: aFileReference [
    | rows |
    rows := self classMetricsRows.

    aFileReference ensureDelete.
    aFileReference writeStreamDo: [ :stream |
        | writer |
        writer := NeoCSVWriter on: stream.
        writer nextPut: #('className' 'nbAttributes' 'nbMethods' 'loc').
        rows do: [ :row | writer nextPut: row ].
    ].

    ^ aFileReference
]

{ #category : 'exporting' }
TP1CSVExporter class >> exportToDocuments [
    | file |
    file := FileLocator documents / 'tp1_classes_metrics.csv'.
    ^ self exportClassesMetricsToCSVAt: file
]
