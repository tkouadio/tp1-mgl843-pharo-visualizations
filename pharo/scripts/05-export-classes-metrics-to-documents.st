"TP1 – NeoCSV: Export classes metrics"
| file |
file := TP1CSVExporter exportToDocuments.
Transcript show: 'CSV généré: ', file fullName; cr.
