# Guide d'installation des mods Kraphtea

Ce guide vous explique comment installer et configurer les mods Kraphtea pour Minecraft 1.20.1 avec Fabric.

## Prérequis

1. **Minecraft Java Edition** (version 1.20.1)
2. **Fabric Loader** (version 0.14.21 ou supérieure)
3. **Fabric API** (version 0.83.0+1.20.1 ou supérieure)

## Installation de Fabric

Si vous n'avez pas encore Fabric installé :

1. Téléchargez l'installateur Fabric depuis [fabricmc.net](https://fabricmc.net/use/)
2. Exécutez l'installateur et sélectionnez Minecraft 1.20.1
3. Cliquez sur "Installer"

## Installation des mods

### Option 1 : Installation manuelle

1. Téléchargez les fichiers JAR des mods depuis la [page des releases](https://github.com/GingerTeacup/kraphtea-mods/releases)
2. Placez ces fichiers dans le dossier `mods` de votre installation Minecraft
   - Windows : `%appdata%\.minecraft\mods`
   - macOS : `~/Library/Application Support/minecraft/mods`
   - Linux : `~/.minecraft/mods`
3. Démarrez Minecraft avec le profil Fabric

### Option 2 : Utilisation du modpack complet

1. Téléchargez le modpack Kraphtea v1.0.6 depuis [le site officiel](https://kraphtea-modpack.com) ou [CurseForge](https://www.curseforge.com)
2. Importez le modpack dans votre lanceur (MultiMC, CurseForge, GDLauncher, etc.)
3. Lancez le jeu

## Mods disponibles

### LootrTweaker (v1.0.6)

Modifie le comportement du mod Lootr pour ajuster le contenu des coffres de butin.

**Dépendances requises :**
- Fabric API
- Lootr 0.7.35.85 ou supérieur

### Enchantment Disabler (v1.0.0)

Permet de désactiver certains enchantements spécifiés.

**Dépendances requises :**
- Fabric API

## Configuration

Après avoir lancé le jeu avec les mods, les fichiers de configuration seront générés automatiquement. Vous pouvez les trouver dans les dossiers suivants :

- **LootrTweaker** : `config/lootr_tweaker/`
- **Enchantment Disabler** : `config/enchantment_disabler/`

### Configuration de LootrTweaker

Modifiez le fichier `config/lootr_tweaker/global_settings.json` pour ajuster les paramètres globaux. Exemple :

```json
{
  "emptySlotRatio": 0.3,
  "maxEmptySlots": 4,
  "itemWeights": {
    "minecraft:iron_ingot": 10.0,
    "minecraft:gold_ingot": 5.0
  },
  "removedItems": [
    "minecraft:netherite_ingot"
  ]
}
```

### Configuration d'Enchantment Disabler

Modifiez le fichier `config/enchantment_disabler/config.json` pour ajuster les enchantements désactivés. Exemple :

```json
{
  "disabledEnchantments": [
    "minecraft:aqua_affinity",
    "minecraft:respiration"
  ]
}
```

## Résolution des problèmes courants

### "Mod missing dependency" (Dépendance manquante)

Si vous voyez une erreur mentionnant une dépendance manquante, assurez-vous d'avoir installé :
- Fabric API
- Lootr (pour LootrTweaker)

### Crash au démarrage

1. Vérifiez que vous utilisez bien Minecraft 1.20.1
2. Vérifiez que vous avez la bonne version de Fabric Loader
3. Consultez les logs dans `.minecraft/logs/latest.log` pour identifier le problème

### Les modifications de configuration ne s'appliquent pas

1. Assurez-vous que votre fichier de configuration utilise un format JSON valide
2. Redémarrez complètement le jeu après avoir modifié la configuration
3. Pour LootrTweaker, utilisez la commande `/lootrTweaker reload` en jeu

## Support et assistance

Si vous rencontrez des problèmes, vous pouvez :
1. Consulter [la documentation](https://github.com/GingerTeacup/kraphtea-mods/tree/main/docs)
2. Ouvrir une [issue sur GitHub](https://github.com/GingerTeacup/kraphtea-mods/issues)
3. Rejoindre le [serveur Discord](https://discord.gg/kraphtea) pour obtenir de l'aide