# Guide d'utilisation de Git LFS pour Kraphtea-Mods

Ce guide explique comment configurer et utiliser Git Large File Storage (LFS) pour gérer efficacement les fichiers volumineux dans le dépôt GitHub du projet Kraphtea-Mods.

## Qu'est-ce que Git LFS?

Git LFS est une extension de Git qui permet de gérer efficacement les fichiers volumineux en les stockant séparément du dépôt principal, tout en gardant une référence à ces fichiers dans le dépôt. Cela améliore les performances de Git lors de la manipulation de grands fichiers binaires comme les JARs, les images, etc.

## Pourquoi utiliser Git LFS?

- **Performances**: Les clones et pulls du dépôt sont plus rapides
- **Espace disque**: Moins d'espace disque utilisé pour les clones
- **Historique propre**: L'historique Git reste propre et léger
- **Collaboration améliorée**: Facilite le travail d'équipe sur des projets contenant des fichiers volumineux

## Installation

1. Téléchargez et installez Git LFS depuis [git-lfs.github.com](https://git-lfs.github.com/)
2. Ouvrez un terminal et exécutez:

```bash
git lfs install
```

## Configuration pour Kraphtea-Mods

### 1. Configuration initiale (déjà incluse dans le dépôt)

Le fichier `.gitattributes` est déjà configuré avec les extensions suivantes gérées par Git LFS:

```
*.jar filter=lfs diff=lfs merge=lfs -text
*.png filter=lfs diff=lfs merge=lfs -text
*.zip filter=lfs diff=lfs merge=lfs -text
```

### 2. Vérification de la configuration

Pour vérifier que Git LFS est correctement configuré:

```bash
git lfs status
```

### 3. Tracking des fichiers existants

Si des fichiers volumineux ont déjà été ajoutés au dépôt, vous pouvez les migrer vers Git LFS:

```bash
git lfs migrate import --include="*.jar,*.png,*.zip" --everything
```

## Workflow quotidien avec Git LFS

### Ajout et commit de fichiers

Avec Git LFS configuré, vous pouvez ajouter et committer des fichiers normalement:

```bash
git add .
git commit -m "Ajout de nouveaux fichiers, y compris de grands fichiers binaires"
```

### Push des modifications

Lorsque vous poussez des modifications incluant des fichiers LFS, Git transfère automatiquement les fichiers LFS:

```bash
git push origin main
```

## Résolution des problèmes courants

### Erreur "Smudge error"

Si vous rencontrez une erreur comme "Smudge error", essayez:

```bash
git lfs pull
```

### Erreur de quota Git LFS

GitHub impose des limites sur la quantité de stockage et de bande passante LFS selon votre forfait. Si vous atteignez cette limite:

1. Vérifiez votre utilisation dans les paramètres du dépôt
2. Envisagez de supprimer d'anciens fichiers inutilisés
3. Passez à un forfait GitHub supérieur si nécessaire

### Fichiers volumineux non trackés par LFS

Si certains fichiers volumineux ne sont pas trackés par LFS alors qu'ils devraient l'être:

```bash
git lfs track "*.extension"
git add .gitattributes
git commit -m "Track *.extension files with Git LFS"
```

## Bonnes pratiques pour Kraphtea-Mods

1. **JARs de build**: Utilisez toujours LFS pour les fichiers JAR générés
2. **Images**: Stockez les grandes images, textures et icônes via LFS
3. **Fichiers temporaires**: Ajoutez les extensions des fichiers temporaires volumineux à `.gitignore`
4. **Dépendances externes**: Évitez d'inclure des dépendances externes directement dans le dépôt

## Vérification avant le push

Avant de pousser vos modifications, exécutez:

```bash
git lfs status
```

Cela vous indiquera quels fichiers seront poussés via Git LFS.

## Workflow pour le projet entier

Pour réinitialiser complètement la gestion Git LFS pour le projet Kraphtea-Mods:

```bash
# Depuis la racine du projet
git lfs install
git lfs track "*.jar" "*.png" "*.zip"
git add .gitattributes
git commit -m "Configuration Git LFS pour fichiers volumineux"
git lfs migrate import --include="*.jar,*.png,*.zip" --everything
git push -f origin main
```

**ATTENTION**: L'option `-f` force le push et peut écraser l'historique. Utilisez uniquement après coordination avec l'équipe.

## Ressources supplémentaires

- [Documentation officielle Git LFS](https://git-lfs.github.com/)
- [GitHub et Git LFS](https://docs.github.com/fr/repositories/working-with-files/managing-large-files/about-git-large-file-storage)
- [Quotas Git LFS sur GitHub](https://docs.github.com/fr/repositories/working-with-files/managing-large-files/about-storage-and-bandwidth-usage)