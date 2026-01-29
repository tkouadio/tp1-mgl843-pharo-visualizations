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

      loc := (c respondsTo: #methods)
        ifTrue: [ (c methods collect: [ :m | self locFromMethod: m ]) sum ]
        ifFalse: [ 0 ].

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
TP1CSVExporter class >> lineCountOf: aString [
  | s |
  aString ifNil: [ ^ 0 ].
  aString isEmpty ifTrue: [ ^ 0 ].

  "Normalise CRLF et CR en LF"
  s := aString copyReplaceAll: (String with: Character cr with: Character lf) with: (String with: Character lf).
  s := s copyReplaceAll: (String with: Character cr) with: (String with: Character lf).

  ^ (s occurrencesOf: Character lf) + 1

]

{ #category : 'exporting' }
TP1CSVExporter class >> locFromMethod: m [
  | text |
  "1) Meilleure source: le texte déjà en mémoire dans le modèle"
  (m respondsTo: #sourceText) ifTrue: [
    text := m sourceText.
    ^ self lineCountOf: text
  ].

  "2) Sinon, pas de LOC dispo"
  ^ 0

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
TP1CSVExporter class >> repoRoot [
  | iceberg |
  iceberg := FileLocator imageDirectory / 'pharo-local' / 'iceberg'.
  (iceberg exists and: [ iceberg isDirectory ]) ifFalse: [
    ^ FileLocator workingDirectory
  ].

  ^ (iceberg directories
      detect: [ :d | (d / 'pharo' / 'scripts' / '00-bootstrap.st') exists ]
      ifNone: [ FileLocator workingDirectory ])
]
