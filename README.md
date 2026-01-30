---

# TP1 – Visualisations Moose / Pharo (MGL843)

Ce dépôt contient les **outils Pharo/Moose** développés dans le cadre du **TP1 du cours MGL843 – Architecture logicielle**, permettant :

* 📊 de **visualiser** un modèle **FAMIX TypeScript** (classes, méthodes, fonctions, fichiers)
* 📁 de **générer un fichier CSV** de métriques (attributs, méthodes, LOC)
* 🧪 de **valider la structure du dépôt** via des tests automatisés (GitHub Actions)

---

## 🧰 Technologies utilisées

* **Pharo 12**
* **Moose Suite 12 (TypeScript)**
* **Famix TypeScript**
* **Roassal3** (visualisations)
* **NeoCSV** (export CSV)
* **Node.js + Jest** (tests CI)
* **GitHub Actions**

---

## 📁 Structure du dépôt

```text
tp1-mgl843-pharo-visualizations/
│
├─ pharo/
│  ├─ scripts/               # Scripts exécutables (FileIn)
│  │  ├─ 00-bootstrap.st
│  │  ├─ 01-open-classes-map.st
│  │  ├─ 02-open-functions-map.st
│  │  ├─ 03-open-methods-map.st
│  │  ├─ 04-open-files-map.st
│  │  └─ 05-export-classes-metrics-to-documents.st
│  │
│  └─ src/                   # Code Smalltalk versionné
│     └─ TP1MGL843-PharoTools/
	  └─ TP1MGL843-PharoTools-Tests/
│
├─ js-tests/                 # Tests automatisés (CI)
│  ├─ __tests__/
│  ├─ src/
│  ├─ package.json
│  └─ jest.config.js
│
└─ .github/workflows/
   └─ ci.yml                 # Pipeline GitHub Actions
```

---

## ✅ Prérequis (OBLIGATOIRES)

Avant d’utiliser les visualisations ou l’export CSV, **le modèle TypeScript doit être importé dans Moose**.

### 1️⃣ Installer Pharo & Moose

* Installer **Pharo Launcher**
* Créer / ouvrir une image :
  **Moose Suite 12 – TypeScript**

---

## 2️⃣ Importer le projet TypeScript dans Moose (OBLIGATOIRE)

⚠️ **Sans cette étape, les métriques (LOC, méthodes, etc.) peuvent être à 0**

Suivre le tutoriel officiel Fuhrmanator :
👉 [https://fuhrmanator.github.io/tuto-famix-ts/](https://fuhrmanator.github.io/tuto-famix-ts/)


---

## ▶️ Utilisation des visualisations

Ouvrir un **Moose Playground ou FileIn(Menu File Browser dans Pharo)** et exécuter les scripts suivants.

### 📦 Chargement des dépendances

```smalltalk
"00-bootstrap.st"
```

Vérifie la présence de :

* Moose
* Roassal
* NeoCSV
* FileLocator

---

### 🟦 Visualisation des classes

```smalltalk
TP1Viz openClassesMap.
```

* Taille = nombre d’attributs
* Hauteur = nombre de méthodes
* Couleur = LOC
* 🔍 **Cliquable** : ouvre la classe dans Moose

---

### 🟩 Visualisation des méthodes

```smalltalk
TP1Viz openMethodsMap.
```

* Taille = nombre d’instructions
* Couleur = LOC
* 🔍 Cliquable

---

### 🟨 Visualisation des fonctions

```smalltalk
TP1Viz openFunctionsMap.
```

* Complexité cyclomatique / statements
* Couleur = LOC
* 🔍 Cliquable

---

### 🟥 Visualisation des fichiers

```smalltalk
TP1Viz openFilesMap.
```

* Taille = nombre de lignes
* Couleur = taille du fichier
* 🔍 Cliquable

---

## 📤 Génération du CSV (métriques)

```smalltalk
TP1CSVExporter exportToDocuments.
```

📄 Fichier généré dans :

```text
Documents/
└─ tp1_classes_metrics.csv
```

Colonnes :

| className | nbAttributes | nbMethods | loc |
| --------- | ------------ | --------- | --- |

---

## 🧪 Tests automatisés (CI)

Les tests **ne testent pas Pharo**, mais :

* la présence des scripts `.st`
* leur contenu minimal attendu
* la structure du CSV
* la cohérence du dépôt

### Lancer localement :

```bash
cd js-tests
npm install
npm test
```

---

### ⚙️ GitHub Actions

* Les tests se lancent automatiquement :

  * à chaque **push**
  * à chaque **pull request**
* Pipeline défini dans :

  ```
  .github/workflows/ci.yml
  ```

---

## ⚠️ Points importants / pièges connus

* ❌ Si le modèle TypeScript n’est **pas importé**, les LOC peuvent être `0`
* ⚠️ Les métriques peuvent varier selon :

  * version de Moose
  * qualité des `SourceAnchor`
* 🟢 Les tests CI **ne valident pas les métriques**, uniquement la structure

---

## 👥 Travail d’équipe

Chaque membre doit :

1. Cloner le dépôt
2. Importer le projet TypeScript **localement** dans Moose
3. Lancer les scripts Pharo
4. Générer le CSV sur sa machine

👉 **Le modèle Moose n’est pas versionné**

---

## 📚 Références

* Fuhrmanator – FAMIX TypeScript
  [https://fuhrmanator.github.io/tuto-famix-ts/](https://fuhrmanator.github.io/tuto-famix-ts/)
* Moose Documentation
  [https://moosetechnology.org/](https://moosetechnology.org/)
* Roassal3
  [https://github.com/ObjectProfile/Roassal3](https://github.com/ObjectProfile/Roassal3)

---

## ✍️ Auteur

TP réalisé dans le cadre du cours **MGL843 – Architecture logicielle**
ÉTS – Hiver 2026

---
