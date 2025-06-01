# Guide Artifact Durability

## Vue d'ensemble

Le mod Artifact Durability ajoute un système de durabilité simulée aux artéfacts normalement indestructibles dans Minecraft 1.20.1 Fabric.

## Fonctionnement

### Détection automatique
- Le mod détecte quand vous équipez un artéfact via Trinkets
- Initialise automatiquement la durabilité (2700 par défaut = 45 heures)
- Fonctionne avec tous les mods d'artéfacts du modpack

### Affichage
- Durabilité visible dans les tooltips : "Durabilité: 2650/2700"
- Couleurs adaptatives : Vert (>60%), Jaune (30-60%), Rouge (<30%)
- Synchronisation temps réel client/serveur

### Stockage
- Données sauvegardées avec le monde via Cardinal Components
- Persistance entre sessions
- Pas de modification des items originaux

## Artéfacts supportés

### Mod Artifacts (35+ items)
- Chapeaux : superstitious_hat, cowboy_hat, top_hat...
- Colliers : lucky_scarf, cross_necklace, panic_necklace...
- Accessoires : cloud_in_a_bottle, crystal_heart, pocket_piston...
- Chaussures : kitty_slippers, bunny_hoppers, running_shoes...
- Gants : power_glove, fire_gauntlet, feral_claws...

### Mod Things (20+ items)
- Outils : displacement_tome, arm_extender, mining_gloves...
- Accessoires : moss_necklace, riot_gauntlet, hades_crystal...
- Consommables : recall_potion, hardening_catalyst...

### Extensible
- Botania, Create, Origins (configuration à définir)
- Ajout facile de nouveaux mods/artéfacts

## Configuration

### Durabilités par défaut
- Tous artéfacts : 2700 minutes (45 heures de jeu)
- Personnalisable via ConfigManager
- Possible ajout interface en jeu (Cloth Config)

### Exceptions possibles
- Artéfacts rares : durabilité plus élevée
- Items consommables : durabilité réduite
- Artéfacts puissants : dégradation accélérée

## Installation

1. Placer le JAR compilé dans le dossier `mods/`
2. S'assurer que les dépendances sont présentes :
   - Fabric API
   - Trinkets
   - Cardinal Components API
3. Redémarrer le serveur
4. Le mod s'active automatiquement

## Développement

- Code source : `mods-in-progress/artifact-durability-mod/`
- Compilation locale recommandée
- Structure modulaire pour ajouts futurs