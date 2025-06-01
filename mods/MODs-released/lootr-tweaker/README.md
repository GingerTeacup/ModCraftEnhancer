# LootrTweaker

Un mod Fabric pour Minecraft 1.20.1 qui modifie le comportement du mod Lootr, permettant d'ajouter des emplacements vides aux tables de butin et de configurer finement les poids des objets.

## Description

LootrTweaker est un mod serveur qui s'intègre au mod Lootr pour offrir un contrôle précis sur le contenu des coffres générés. Il permet notamment:

- D'ajouter des emplacements vides pour rendre les coffres moins remplis
- De configurer le poids (chance d'apparition) de chaque objet
- D'exclure certains objets des tables de butin
- D'ajouter de nouveaux objets à des tables de butin spécifiques
- De configurer globalement ou par table de butin

Ce mod est particulièrement utile pour les modpacks qui souhaitent ajuster la progression et l'équilibre du jeu en maîtrisant précisément le contenu des coffres de butin.

## Prérequis

- Minecraft 1.20.1
- Fabric Loader 0.14.21+
- Fabric API 0.83.0+1.20.1
- Lootr 0.7.30+ (testé avec 0.7.35.85)

## Installation

1. Assurez-vous d'avoir Fabric et le mod Lootr installés
2. Téléchargez le fichier JAR de LootrTweaker depuis la section Releases
3. Placez-le dans le dossier `mods` de votre serveur ou installation Minecraft
4. Démarrez le jeu ou le serveur

## Configuration

Après le premier démarrage, un dossier de configuration sera créé à l'emplacement suivant:
```
config/lootr_tweaker/
```

### Configuration globale

Le fichier `global_settings.json` contient les paramètres globaux qui s'appliquent à toutes les tables de butin:

```json
{
  "emptySlotRatio": 0.3,
  "maxEmptySlots": 4,
  "itemWeights": {
    "minecraft:iron_ingot": 10.0,
    "minecraft:gold_ingot": 5.0,
    "minecraft:diamond": 1.0
  },
  "removedItems": [
    "minecraft:netherite_ingot",
    "minecraft:enchanted_golden_apple"
  ],
  "additionalItems": {
    "lootr:oceanmonument/oceanmonument": [
      "minecraft:heart_of_the_sea",
      "minecraft:trident"
    ]
  }
}
```

#### Paramètres

- `emptySlotRatio`: Pourcentage des emplacements qui seront vides (0.3 = 30%)
- `maxEmptySlots`: Nombre maximum d'emplacements vides par coffre
- `itemWeights`: Poids personnalisés pour chaque objet (plus le nombre est élevé, plus il est commun)
- `removedItems`: Liste d'objets à retirer de toutes les tables de butin
- `additionalItems`: Objets supplémentaires à ajouter à des tables de butin spécifiques

### Configuration par table de butin

Pour personnaliser une table de butin spécifique, créez un fichier JSON dans le dossier `config/lootr_tweaker/loot_tables/` avec le nom de la table. Par exemple pour personnaliser la table `lootr:abandoned_mineshaft/mineshaft_chest`, créez un fichier nommé `lootr:abandoned_mineshaft/mineshaft_chest.json`:

```json
{
  "emptySlotRatio": 0.5,
  "maxEmptySlots": 6,
  "itemWeights": {
    "minecraft:iron_pickaxe": 15.0,
    "minecraft:rail": 20.0
  },
  "removedItems": [
    "minecraft:golden_apple"
  ],
  "additionalItems": [
    "minecraft:minecart",
    "minecraft:torch"
  ]
}
```

Les paramètres spécifiques à une table de butin remplacent les paramètres globaux.

## Commandes

LootrTweaker ajoute les commandes suivantes:

- `/lootrTweaker reload` - Recharge la configuration
- `/lootrTweaker analyzeWeights` - Analyse et enregistre les poids des objets dans les tables de butin

Ces commandes nécessitent un niveau d'opérateur 2 ou supérieur.

## Notes sur les poids

Le système de poids fonctionne comme suit:

1. Plus un objet a un poids élevé, plus il a de chances d'apparaître
2. Définir un poids de 0 pour un objet le retire complètement
3. Les poids sont relatifs entre eux (un objet avec un poids de 10 est deux fois plus commun qu'un objet avec un poids de 5)
4. Si aucun poids n'est spécifié pour un objet, son poids original est conservé

## Identification des tables de butin

Pour identifier les tables de butin à configurer, utilisez la commande `/lootrTweaker analyzeWeights` qui générera des fichiers dans le dossier `logs/` contenant les informations sur toutes les tables de butin.

Les noms de tables courants incluent:
- `lootr:abandoned_mineshaft/mineshaft_chest`
- `lootr:simple_dungeon/simple_dungeon_chest`
- `lootr:stronghold/library`
- `lootr:village/village_weaponsmith`

## Compatibilité

- Ce mod est conçu pour fonctionner côté serveur, aucune installation côté client n'est nécessaire.
- Compatible avec les autres mods du modpack Kraphtea v1.0.6
- Compatible avec Enchantment Disabler pour une gestion complète du contenu des coffres et des enchantements

## Développement

### Compilation

1. Clonez ce dépôt
2. Exécutez `./gradlew build`
3. Le fichier JAR compilé se trouvera dans `build/libs/`

## Licence

Ce projet est sous licence MIT.

## Contributeurs

- Kraphtea (Mainteneur principal)

## Remerciements

- L'équipe derrière le mod Lootr
- La communauté Fabric pour leurs outils et support