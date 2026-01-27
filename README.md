# TP1 MGL843 — Pharo Tools (Roassal + NeoCSV)

Ce dépôt contient le **code Pharo** (Tonel) permettant :
- Visualisations Roassal : classes, fonctions, méthodes, fichiers
- Export CSV des métriques de classes via NeoCSV

## Prérequis
- Pharo 12
- Moose + Famix TypeScript + Roassal
- Modèle FAMIX TypeScript déjà importé dans l’image (MooseModel root first)

## Utilisation (scripts type Playground)
Dans Pharo : `File Browser` → sélectionner un script dans `pharo/scripts/` → **FileIn**.

Ordre recommandé :
1. `00-bootstrap.st`
2. `01-viz-classes.st`
3. `02-viz-functions.st`
4. `03-viz-methods.st`
5. `04-viz-files.st`
6. `05-export-classes-csv.st` (produit `classes.csv`)

## Tests (Jest)
Les tests Jest valident la présence des scripts et la cohérence du schéma CSV.

```bash
cd js-tests
npm ci
npm test