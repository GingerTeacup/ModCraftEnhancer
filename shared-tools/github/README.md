# Scripts de synchronisation GitHub

## Scripts disponibles

### `replit-github-sync-workflow.sh`
- **Usage principal** : Synchronisation automatique bidirectionnelle
- Utilisé par le workflow Replit "Auto GitHub Sync"
- Pull et push automatiques avec gestion sécurisée du token

### `pull-from-github.sh`
- **Pull sélectif** : Récupère uniquement les pull requests acceptées
- Synchronisation incrémentale basée sur les commits
- Idéal pour éviter les conflits

### `github-sync-interactive.sh`
- **Push interactif** : Demande un message de commit
- Interface utilisateur conviviale
- Contrôle manuel des modifications à synchroniser

### `secure-github-sync.sh`
- **Wrapper sécurisé** : Utilise GITHUB_PERSONAL_ACCESS_TOKEN
- Évite l'exposition du token dans les fichiers
- Fallback vers les autres scripts

## Configuration requise

Variables d'environnement :
- `GITHUB_TOKEN` ou `GITHUB_PERSONAL_ACCESS_TOKEN`
- Dépôt cible : `GingerTeacup/ModCraftEnhancer`
- Dossier source : `kraphtea-mods`

## Utilisation

```bash
# Synchronisation automatique (Replit)
./replit-github-sync-workflow.sh

# Pull seulement
./pull-from-github.sh

# Push interactif
./github-sync-interactive.sh

# Wrapper sécurisé
./secure-github-sync.sh [pull]
```