# Changelog Version 6 - DÉTECTION AUTOMATIQUE COMPLÈTE

## Problèmes résolus

### Script de compilation entièrement recodé
- **Détection automatique** de tous les mods dans MODs-released et MODs-in-progress
- **Fermeture invite de commande corrigée** avec pause appropriées
- **Navigation entre dossiers améliorée** avec retour automatique au bon répertoire
- **Gestion d'erreurs robuste** pour éviter les plantages

### Nouvelles fonctionnalités
- **Scan automatique** des projets avec build.gradle au démarrage
- **Affichage du type** de mod (released/in-progress)
- **Compilation sélective** par mod ou compilation globale
- **Comptage des mods** détectés en temps réel
- **Vérification environnement** sans fermeture forcée

### Améliorations techniques
- Variables dynamiques avec enabledelayedexpansion
- Boucles pour parcourir automatiquement tous les mods
- Gestion des chemins relatifs corrigée
- Messages d'erreur informatifs

## Utilisation
1. Extraire l'archive
2. Naviguer vers shared-tools/
3. Lancer kraphtea-tools.bat
4. Option 2 pour compilation avec détection automatique
5. Option 3 pour vérification environnement

Le programme détecte maintenant automatiquement tous vos mods et permet une compilation complète sans intervention manuelle.