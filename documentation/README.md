# Kraphtea Mods Collection

Collection de mods Fabric pour Minecraft 1.20.1 compatibles avec le modpack Kraphtea.

## Vue d'ensemble

Cette collection de mods a été spécialement conçue pour améliorer l'expérience de jeu du modpack Kraphtea tout en conservant son essence et son équilibre. Chaque mod est développé avec un objectif précis d'amélioration du gameplay sans ajouter de complexité inutile.

## Structure du projet

Le projet est organisé de manière modulaire pour faciliter le développement, la maintenance et l'extension de la collection de mods:

```
kraphtea-mods/
├── shared-tools/                # Outils et ressources partagés entre les mods
│   ├── compilation/             # Scripts de compilation optimisés
│   ├── templates/               # Templates pour créer rapidement de nouveaux mods
│   └── migration/               # Outils pour migrer les mods existants vers cette structure
├── lootr-tweaker/               # Mod pour ajuster le comportement de Lootr
├── enchantment-disabler/        # Mod pour désactiver certains enchantements
└── docs/                        # Documentation détaillée
```

## Mods disponibles

### LootrTweaker (v1.0.6)

Modifie le comportement du mod Lootr pour ajouter des emplacements vides aux loot tables et offrir une configuration fine des poids des items.

**Caractéristiques principales:**
- Configuration par mod et par table de butin
- Ajout configurable d'emplacements vides dans les coffres
- Système de poids pour les items avec priorités
- Possibilité d'exclure certains items des tables de butin
- Outils d'analyse des tables de butin

**Compatibilité:** Lootr 0.7.35.85+, Fabric Loader 0.14.21+, Minecraft 1.20.1

### Enchantment Disabler (v1.0.0)

Permet de désactiver complètement certains enchantements spécifiés, utile pour l'équilibrage du gameplay.

**Caractéristiques principales:**
- Désactivation par identifiant d'enchantement
- Configuration simple par fichier JSON
- Suppression complète des enchantements désactivés
- Fonctionne sur tous les items, y compris ceux dans les tables de butin

**Compatibilité:** Fabric Loader 0.14.21+, Minecraft 1.20.1

## Utilisation

### Installation

1. Assurez-vous d'avoir Fabric installé pour Minecraft 1.20.1
2. Téléchargez les fichiers JAR des mods depuis la section "Releases"
3. Placez les fichiers JAR dans le dossier `mods` de votre installation Minecraft
4. Lancez le jeu

### Configuration

Chaque mod possède son propre dossier de configuration dans le dossier `config` de Minecraft:

- LootrTweaker: `config/lootr_tweaker/`
- Enchantment Disabler: `config/enchantment_disabler/`

Les fichiers de configuration utilisent le format JSON et sont générés automatiquement au premier lancement.

## Développement

### Prérequis

- JDK 17 ou supérieur
- Git (avec Git LFS pour les fichiers volumineux)
- IDE Java (recommandé: IntelliJ IDEA ou Visual Studio Code avec les extensions Java)

### Création d'un nouveau mod

Pour créer un nouveau mod, utilisez le script `create-new-mod.bat` dans le dossier `shared-tools`:

```batch
cd shared-tools
create-new-mod.bat nom_du_mod
```

Cela créera un nouveau dossier avec la structure complète nécessaire pour commencer le développement.

### Compilation

Chaque mod possède son propre script `compile.bat` qui utilise le compilateur commun optimisé:

```batch
cd nom_du_mod
compile.bat
```

Ce script intègre des optimisations de mémoire et gère automatiquement les dépendances.

### Conventions de code

- Utiliser le format standard Java
- Documenter toutes les classes publiques
- Structurer le code selon les packages définis
- Suivre les principes SOLID

### Tests

Avant chaque release:
1. Tester le mod en solo (client)
2. Tester le mod en serveur dédié
3. Vérifier la compatibilité avec les autres mods de la collection
4. S'assurer que le mod reste fidèle à la philosophie du modpack Kraphtea

## Philosophie de développement

Les mods Kraphtea suivent ces principes:

1. **Indépendance**: Chaque mod fonctionne de manière autonome sans dépendance inutile
2. **Compatibilité**: Tous les mods sont testés ensemble pour assurer qu'ils fonctionnent correctement
3. **Configuration**: Chaque mod offre des options de configuration flexibles et intuitives
4. **Performance**: Les mods sont optimisés pour minimiser leur impact sur les performances du jeu
5. **Équilibre**: Les modifications apportées respectent l'équilibre du gameplay original

## Contribution

Pour contribuer à ce projet:

1. Créez un fork du dépôt
2. Créez une branche pour votre fonctionnalité (`git checkout -b feature/amazing-feature`)
3. Committez vos changements (`git commit -m 'Add some amazing feature'`)
4. Poussez la branche (`git push origin feature/amazing-feature`)
5. Ouvrez une Pull Request

## Licence

Tous les mods sont sous licence MIT.

## Contact

Pour toute question ou suggestion, ouvrez une issue sur GitHub ou contactez-nous via Discord.