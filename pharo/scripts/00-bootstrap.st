"TP1-MGL843 – Bootstrap: vérifie Moose/Roassal/NeoCSV"
#(MooseModel RSCanvas NeoCSVWriter FileLocator) do: [ :cls |
  (Smalltalk hasClassNamed: cls) ifFalse: [ self error: 'Classe manquante: ', cls asString ] ].
Transcript show: 'OK: Moose/Roassal/NeoCSV/FileLocator dispo'; cr.