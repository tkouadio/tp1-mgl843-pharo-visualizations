## 🔴 Pourquoi l’erreur se produit

Dans GitHub :

```markdown
---
# TP1 – Visualisations Moose / Pharo (MGL843)
...
---
```

👉 Les `---` au début indiquent à GitHub :

> « ce qui suit est du **YAML** »

Or ton contenu **n’est pas du YAML** (emojis, `**bold**`, `:` dans le texte, etc.), d’où l’erreur :

> `did not find expected alphabetic or numeric character while scanning an alias`

---

## ✅ Solution (la bonne)

### ✔️ **Supprimer les délimiteurs YAML `---`**

Un README **n’a pas besoin** de front-matter YAML sur GitHub.

---

## ✅ README corrigé (fonctionne à 100 %)

👉 **Copie-colle exactement ceci** comme contenu de ton `README.md` :

````markdown
# TP1 – Visualisations Moose / Pharo (MGL843)

Ce dépôt contient les **outils Pharo/Moose** développés dans le cadre du  
**TP1 du cours MGL843 – Architecture logicielle**, permettant :

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
│        └─ TP1MGL843-PharoTools-Tests/
│
├─ js-tests/                 # Tests automatisés (CI)
│  ├─ __tests__/
│  ├─ src/
│  ├─ package.json
│  └─ jest.config.js
│
└─ .github/workflows/
   └─ ci.yml                 # Pipeline GitHub Actions
````

---

## ✅ Prérequis (OBLIGATOIRES)

Avant d’utiliser les visualisations ou l’export CSV,
**le modèle TypeScript doit être importé dans Moose**.

### 1️⃣ Installer Pharo & Moose

* Installer **Pharo Launcher**
* Créer / ouvrir une image : **Moose Suite 12 – TypeScript**

---

## 2️⃣ Importer le projet TypeScript dans Moose (OBLIGATOIRE)

⚠️ **Sans cette étape, les métriques (LOC, méthodes, etc.) peuvent être à 0**

Tutoriel officiel :
👉 [https://fuhrmanator.github.io/tuto-famix-ts/](https://fuhrmanator.github.io/tuto-famix-ts/)

---

## ▶️ Utilisation des visualisations

Ouvrir un **Moose Playground** ou utiliser **FileIn** dans Pharo.

### 📦 Chargement des dépendances

```smalltalk
"00-bootstrap.st"
```

---

### 🟦 Visualisation des classes

```smalltalk
TP1Viz openClassesMap.
```

* Taille = attributs
* Hauteur = méthodes
* Couleur = LOC
* 🔍 Cliquable

---

### 🟩 Visualisation des méthodes

```smalltalk
TP1Viz openMethodsMap.
```

---

### 🟨 Visualisation des fonctions

```smalltalk
TP1Viz openFunctionsMap.
```

---

### 🟥 Visualisation des fichiers

```smalltalk
TP1Viz openFilesMap.
```

---

## 📤 Génération du CSV

```smalltalk
TP1CSVExporter exportToDocuments.
```

📄 Généré dans :

```text
Documents/tp1_classes_metrics.csv
```

---

## 🧪 Tests automatisés (CI)

```bash
cd js-tests
npm install
npm test
```

---

## 👥 Travail d’équipe

👉 **Le modèle Moose n’est pas versionné**
Chaque membre importe le projet TypeScript localement.

---

## 📚 Références

* [https://fuhrmanator.github.io/tuto-famix-ts/](https://fuhrmanator.github.io/tuto-famix-ts/)
* [https://moosetechnology.org/](https://moosetechnology.org/)
* [https://github.com/ObjectProfile/Roassal3](https://github.com/ObjectProfile/Roassal3)

---

## ✍️ Auteur

TP réalisé dans le cadre du cours **MGL843 – Architecture logicielle**
ÉTS – Hiver 2026

```

---

