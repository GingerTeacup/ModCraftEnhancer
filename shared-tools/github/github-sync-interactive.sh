#!/bin/bash

# Script interactif pour pousser les modifications vers GitHub
# Usage: ./github-sync-interactive.sh

# Configuration
GITHUB_REPO="GingerTeacup/ModCraftEnhancer"
SOURCE_DIR="kraphtea-mods"
BRANCH="main"

echo "==============================================="
echo "  Synchronisation avec GitHub"
echo "  Dépôt cible: $GITHUB_REPO"
echo "==============================================="

# Demande du message de commit
echo "Entrez votre message de commit:"
read -r COMMIT_MSG

if [ -z "$COMMIT_MSG" ]; then
    echo "Erreur: Le message de commit ne peut pas être vide."
    exit 1
fi

echo "Message de commit: \"$COMMIT_MSG\""
echo ""

# Vérification de la présence du dossier source
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Erreur: Le dossier source $SOURCE_DIR n'existe pas!"
    exit 1
fi

# Création d'un dossier temporaire
TEMP_DIR=$(mktemp -d)
echo "Dossier temporaire créé: $TEMP_DIR"

# Clone du dépôt GitHub (shallow clone pour plus de rapidité)
echo "Clonage du dépôt $GITHUB_REPO..."
git clone --depth 1 "https://github.com/$GITHUB_REPO.git" "$TEMP_DIR/repo" || {
    echo "Erreur: Impossible de cloner le dépôt. Vérifiez l'URL et vos droits d'accès."
    echo "Note: Pour pousser vers GitHub, vous devrez utiliser un token d'accès personnel."
    echo "Consultez: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token"
    exit 1
}

# Copie des fichiers de Replit vers le clone local
echo "Copie des fichiers du projet..."
rsync -a --delete "$SOURCE_DIR/" "$TEMP_DIR/repo/" || {
    echo "Erreur lors de la copie des fichiers."
    exit 1
}

# Configuration de Git LFS si nécessaire
echo "Configuration de Git LFS..."
cd "$TEMP_DIR/repo"
git lfs install || echo "Git LFS n'est pas installé ou a rencontré une erreur."

# Demande des informations d'identification GitHub
echo "==============================================="
echo "  Informations d'identification GitHub"
echo "==============================================="
echo "Entrez votre nom d'utilisateur GitHub:"
read -r GIT_USERNAME

echo "Entrez votre token d'accès personnel GitHub:"
read -rs GIT_TOKEN
echo ""

if [ -z "$GIT_USERNAME" ] || [ -z "$GIT_TOKEN" ]; then
    echo "Erreur: Le nom d'utilisateur et le token sont requis."
    exit 1
fi

# Configuration Git pour le commit
git config user.name "Replit Contributor"
git config user.email "contributor@example.com"

# Configuration des informations d'identification pour ce push
git config credential.helper store
echo "https://$GIT_USERNAME:$GIT_TOKEN@github.com" > "$HOME/.git-credentials"
chmod 600 "$HOME/.git-credentials"

# Ajout des fichiers et commit
echo "Ajout des modifications au dépôt..."
git add -A
git status

echo "==============================================="
echo "Les fichiers ci-dessus seront commités et poussés vers GitHub."
echo "Message de commit: $COMMIT_MSG"
echo "==============================================="
echo "Pour continuer, appuyez sur Entrée. Pour annuler, appuyez sur Ctrl+C."
read -r

git commit -m "$COMMIT_MSG" || {
    echo "Erreur lors du commit."
    exit 1
}

# Push vers GitHub
echo "Push vers GitHub..."
git push origin "$BRANCH" || {
    echo "Erreur lors du push."
    echo "Vérifiez vos informations d'identification et essayez à nouveau."
    exit 1
}

echo "==============================================="
echo "  Push réussi vers $GITHUB_REPO"
echo "==============================================="

# Nettoyage
cd -
rm -rf "$TEMP_DIR"
rm -f "$HOME/.git-credentials"
echo "Nettoyage terminé."