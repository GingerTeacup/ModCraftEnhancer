# Améliorations du Projet Kraphtea Mods

Ce document récapitule les améliorations apportées à la structure du projet et aux outils de développement.

## Modifications principales

### 1. Configuration améliorée
- Les fichiers de configuration sont maintenant recherchés dans le répertoire du modpack
- Structure standardisée avec `config/lootr_tweaker/` pour les configurations

### 2. Outils de compilation
- Nouveau menu principal centralisé (`kraphtea-tools.bat`)
- Scripts de compilation améliorés avec détection automatique des mods
- Support pour compiler un mod spécifique ou tous les mods
- Meilleure gestion des erreurs et reporting

### 3. Structure du projet
- Réorganisation des assets pour une meilleure clarté
- Documentation améliorée
- Uniformisation des fichiers Gradle dans tous les modules

### 4. Gestion GitHub
- Synchronisation sélective avec GitHub (uniquement les changements des pull requests)
- Meilleure détection des fichiers modifiés
- Protection des fichiers locaux spécifiques

## Comment utiliser les nouveaux outils

### Menu principal
Exécutez `kraphtea-tools.bat` à la racine du projet pour accéder au menu principal.

### Compilation
- Option 1 du menu principal : Accès au menu de compilation
- Vous pouvez compiler un mod spécifique ou tous les mods
- Les résultats de compilation sont clairement affichés

### Création de nouveaux mods
- Option 2 du menu principal : Assistant de création de mod
- Le système génère automatiquement la structure complète
- Tous les fichiers nécessaires sont créés (gradle, sources, etc.)

### Synchronisation GitHub
- Option 3 du menu principal : Outils de synchronisation GitHub
- Vous pouvez récupérer ou envoyer des modifications
- La synchronisation est plus intelligente et ciblée

## Notes pour les développeurs

1. **Gradle** : Tous les mods utilisent maintenant Gradle 8.1.1 pour la compilation
2. **Environnement de développement** : Compatible avec Java 17+
3. **Tests** : La compilation peut être effectuée via les scripts ou directement avec les commandes Gradle standard
4. **Compatibilité** : Mods configurés pour Minecraft 1.20.1 et Fabric API