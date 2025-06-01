# Installation et utilisation locale - Kraphtea Tools

## Contenu du package

Ce package contient tout le nécessaire pour compiler vos mods Minecraft localement :

- **kraphtea-tools.bat** : Menu principal des outils de développement
- **MODs-released/** : Mods terminés (lootr-tweaker, enchantment-disabler)
- **MODs-in-progress/** : Mod en cours (artifact-durability-mod)
- **shared-tools/** : Outils de compilation et templates

## Prérequis sur votre machine

1. **Java 17 ou 21** (requis pour Minecraft 1.20.1)
2. **Windows** (pour l'utilisation des fichiers .bat)

## Installation

1. Extrayez le contenu dans un dossier de votre choix
2. Naviguez vers le dossier `kraphtea-mods/shared-tools/`
3. Double-cliquez sur **kraphtea-tools.bat**

## Utilisation

### Menu principal (kraphtea-tools.bat)
1. Menu de compilation de mods
2. Créer un nouveau mod
3. Synchroniser avec GitHub
4. Documentation
5. Quitter

### Menu de compilation
1. Compiler lootr-tweaker
2. Compiler enchantment-disabler
3. Compiler artifact-durability-mod (en cours)
4. Compiler tous les mods
5. Vérifier l'environnement
6. Quitter

## Notes importantes

- **Gradle 8.6** : Le wrapper a été mis à jour pour artifact-durability-mod
- **Première compilation** : Gradle téléchargera automatiquement les dépendances
- **Fichiers de sortie** : Les .jar compilés seront dans `[mod]/build/libs/`

## En cas de problème

1. Vérifiez que Java 17+ est installé : `java -version`
2. Vérifiez l'environnement via l'option 5 du menu de compilation
3. Les logs d'erreur s'affichent directement dans la console

## Structure des projets

```
mods/
├── kraphtea-tools.bat          # Menu principal
├── MODs-released/              # Projets terminés
├── MODs-in-progress/           # Projets en cours
├── MODs-future/                # Idées futures
└── shared-tools/               # Outils de développement
    └── compilation/            # Scripts de compilation
```