# Enchantment Disabler

Mod Minecraft Fabric qui permet de désactiver facilement certains enchantements, idéal pour l'équilibrage de gameplay du modpack Kraphtea.

## Description

Enchantment Disabler est un mod serveur léger pour Minecraft 1.20.1 qui permet aux administrateurs de serveur et aux joueurs de désactiver complètement certains enchantements spécifiés. Cela peut être utile pour:

- Désactiver certains enchantements trop puissants pour maintenir l'équilibre du jeu
- Supprimer des enchantements qui interfèrent avec d'autres mods
- Créer des défis de gameplay personnalisés en limitant certains enchantements

## Fonctionnalités

- Désactivation complète d'enchantements par identifiant
- Configuration simple via un fichier JSON
- Empêche l'application des enchantements désactivés sur tous les items
- Compatible avec les coffres de butin et le système d'enchantement
- Impact minimal sur les performances
- Fonctionne côté serveur uniquement, aucune installation côté client nécessaire

## Installation

1. Assurez-vous d'avoir Fabric installé pour Minecraft 1.20.1
2. Téléchargez le dernier fichier JAR depuis la section Releases
3. Placez le fichier JAR dans le dossier `mods` de votre serveur ou installation Minecraft
4. Lancez le jeu ou le serveur

## Configuration

Après le premier lancement, un dossier de configuration sera créé à l'emplacement suivant:
```
config/enchantment_disabler/config.json
```

Le fichier de configuration par défaut ressemble à ceci:
```json
{
  "disabledEnchantments": [
    "minecraft:aqua_affinity",
    "minecraft:respiration"
  ]
}
```

### Désactivation d'enchantements

Pour désactiver un enchantement, ajoutez son identifiant complet à la liste `disabledEnchantments`. Par exemple:

```json
{
  "disabledEnchantments": [
    "minecraft:aqua_affinity",
    "minecraft:respiration",
    "minecraft:depth_strider",
    "minecraft:frost_walker"
  ]
}
```

### Liste des identifiants d'enchantements

Voici quelques identifiants courants d'enchantements vanilla:

- `minecraft:aqua_affinity` - Affinité aquatique
- `minecraft:respiration` - Respiration
- `minecraft:protection` - Protection
- `minecraft:fire_protection` - Protection contre le feu
- `minecraft:feather_falling` - Chute amortie
- `minecraft:blast_protection` - Protection contre les explosions
- `minecraft:projectile_protection` - Protection contre les projectiles
- `minecraft:thorns` - Épines
- `minecraft:depth_strider` - Agilité aquatique
- `minecraft:frost_walker` - Semelles givrantes
- `minecraft:soul_speed` - Vitesse des âmes
- `minecraft:sharpness` - Tranchant
- `minecraft:smite` - Châtiment
- `minecraft:bane_of_arthropods` - Fléau des arthropodes
- `minecraft:knockback` - Recul
- `minecraft:fire_aspect` - Aura de feu
- `minecraft:looting` - Butin
- `minecraft:sweeping` - Affilage
- `minecraft:efficiency` - Efficacité
- `minecraft:silk_touch` - Toucher de soie
- `minecraft:unbreaking` - Solidité
- `minecraft:fortune` - Fortune
- `minecraft:power` - Puissance
- `minecraft:punch` - Frappe
- `minecraft:flame` - Flamme
- `minecraft:infinity` - Infinité
- `minecraft:luck_of_the_sea` - Chance de la mer
- `minecraft:lure` - Appât
- `minecraft:loyalty` - Loyauté
- `minecraft:impaling` - Empalement
- `minecraft:riptide` - Impulsion
- `minecraft:channeling` - Canalisation
- `minecraft:multishot` - Tir multiple
- `minecraft:quick_charge` - Charge rapide
- `minecraft:piercing` - Perforation
- `minecraft:mending` - Raccommodage
- `minecraft:curse_of_vanishing` - Malédiction de disparition
- `minecraft:curse_of_binding` - Malédiction du lien éternel
- `minecraft:swift_sneak` - Furtivité rapide

Pour les enchantements ajoutés par d'autres mods, consultez la documentation du mod ou utilisez la commande `/enchant` en mode créatif pour voir les identifiants.

## Compatibilité

- Compatible avec Minecraft 1.20.1
- Nécessite Fabric Loader 0.14.21 ou supérieur
- Compatible avec Fabric API 0.83.0+1.20.1 ou supérieur
- Compatible avec la plupart des mods du modpack Kraphtea v1.0.6
- Compatible avec le mod LootrTweaker

## Développement

### Prérequis

- JDK 17
- Git

### Compilation

1. Clonez ce dépôt
2. Exécutez `./gradlew build`
3. Le fichier JAR compilé se trouvera dans `build/libs/`

## Licence

Ce projet est sous licence MIT.

## Contributeurs

- Kraphtea (Mainteneur principal)

## Remerciements

- L'équipe de Fabric pour leur excellent API
- La communauté Minecraft Modding pour leur support et inspiration