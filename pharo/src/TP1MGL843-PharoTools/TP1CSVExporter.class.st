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

		className := (c respondsTo: #name)
			ifTrue: [ c name ]
			ifFalse: [ c asString ].

		attrs := (c respondsTo: #numberOfAttributes)
			ifTrue: [ c numberOfAttributes ]
			ifFalse: [ 0 ].

		meths := (c respondsTo: #numberOfMethods)
			ifTrue: [ c numberOfMethods ]
			ifFalse: [ 0 ].

		loc := (c respondsTo: #numberOfLinesOfCode)
			ifTrue: [ c numberOfLinesOfCode ]
			ifFalse: [ 0 ].

		"Fallback robuste en LIGNES"
		(loc = 0 and: [ c respondsTo: #methods ]) ifTrue: [
			loc := (c methods collect: [ :m |
				self locFromMethod: m
			]) sum.
		].

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

{ #category : 'exporting' }
TP1CSVExporter class >> locFromMethod: m [
	| a file text segment start end |

	(m respondsTo: #sourceAnchor) ifFalse: [ ^ 0 ].
	a := m sourceAnchor.
	a ifNil: [ ^ 0 ].

	((a respondsTo: #fileName)
		and: [ a respondsTo: #startPos ]
		and: [ a respondsTo: #endPos ]) ifFalse: [ ^ 0 ].

	file := (FileLocator workingDirectory / a fileName) asFileReference.
	file exists ifFalse: [ ^ 0 ].

	text := file contents.
	start := a startPos max: 1.
	end := a endPos min: text size.
	(end < start) ifTrue: [ ^ 0 ].

	segment := text copyFrom: start to: end.

	"LOC réel = nombre de lignes"
	^ (segment occurrencesOf: Character lf) + 1
]

{ #category : 'exporting' }
TP1CSVExporter class >> locFromMethod: m repoRoot: repoRoot [ [
	| a fileRef text segment start end |
	(m respondsTo: #sourceAnchor) ifFalse: [ ^ 0 ].
	a := m sourceAnchor.
	a ifNil: [ ^ 0 ].

	((a respondsTo: #startPos) and: [ a respondsTo: #endPos ]) ifFalse: [ ^ 0 ].

	"Essaye de retrouver le fichier du sourceAnchor"
	(a respondsTo: #fileName) ifFalse: [ ^ 0 ].
	fileRef := (repoRoot / a fileName) asFileReference.
	fileRef exists ifFalse: [ ^ 0 ].

	text := fileRef contents.
	start := a startPos max: 1.
	end := a endPos min: text size.
	(end < start) ifTrue: [ ^ 0 ].

	segment := (text copyFrom: start to: end).

	"LOC = nb de lignes du segment"
	^ (segment occurrencesOf: Character lf) + 1
]
]

{ #category : 'exporting' }
TP1CSVExporter class >> repoRoot [ [
	"Racine du projet cloné (à adapter si besoin). Option simple: dossier du working directory."
	^ FileLocator workingDirectory
]
]
