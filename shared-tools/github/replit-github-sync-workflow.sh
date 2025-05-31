#!/bin/bash

# Workflow sécurisé pour synchroniser avec GitHub
# Utilise uniquement la variable d'environnement GITHUB_TOKEN sans l'afficher
# Usage: ./replit-github-sync-workflow.sh

# Configuration
GITHUB_REPO="GingerTeacup/ModCraftEnhancer"
SOURCE_DIR="kraphtea-mods"
BRANCH="main"

echo "==============================================="
echo "$(date): Démarrage de la synchronisation GitHub"
echo "==============================================="

# Étape 1: Pull depuis GitHub pour récupérer les dernières modifications
echo "$(date): Étape 1 - Récupération des modifications depuis GitHub"

# Création d'un dossier temporaire pour le pull
TEMP_PULL_DIR=$(mktemp -d)
echo "Dossier temporaire créé pour le pull: $TEMP_PULL_DIR"

# Clone du dépôt GitHub
echo "Clonage du dépôt..."
if [ -n "${GITHUB_TOKEN}" ]; then
    # Utilisation du token sans l'afficher
    git clone --depth 1 "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPO}.git" "$TEMP_PULL_DIR/repo" > /dev/null 2>&1
else
    git clone --depth 1 "https://github.com/${GITHUB_REPO}.git" "$TEMP_PULL_DIR/repo" > /dev/null 2>&1
fi

if [ $? -ne 0 ]; then
    echo "$(date): ERREUR - Impossible de cloner le dépôt GitHub."
    echo "Vérifiez la connectivité réseau et les permissions du dépôt."
    rm -rf "$TEMP_PULL_DIR"
    exit 1
fi

# Vérification si le dossier local existe
if [ ! -d "$SOURCE_DIR" ]; then
    echo "$(date): Le dossier source local $SOURCE_DIR n'existe pas, création..."
    mkdir -p "$SOURCE_DIR"
fi

# Sauvegarde des fichiers locaux spécifiques avant le pull
echo "$(date): Sauvegarde des fichiers locaux spécifiques..."
BACKUP_DIR=$(mktemp -d)
# Ajoutez ici la sauvegarde de fichiers spécifiques

# Copie des fichiers du dépôt cloné vers le local
echo "$(date): Mise à jour des fichiers locaux avec les dernières modifications GitHub..."
cp -r "$TEMP_PULL_DIR/repo/"* "$SOURCE_DIR/" 2>/dev/null

# Restauration des fichiers sauvegardés
echo "$(date): Restauration des fichiers locaux spécifiques..."
# Ajoutez ici la restauration de fichiers spécifiques

# Nettoyage des fichiers temporaires du pull
rm -rf "$TEMP_PULL_DIR" "$BACKUP_DIR"
echo "$(date): Pull depuis GitHub terminé."

# Étape 2: Vérification si des changements locaux doivent être poussés vers GitHub
echo "$(date): Étape 2 - Vérification des modifications locales à pousser..."

# Uniquement tenter de pousser si le token GitHub est disponible
if [ -n "${GITHUB_TOKEN}" ]; then
    # Création d'un dossier temporaire pour le push
    TEMP_PUSH_DIR=$(mktemp -d)
    echo "Dossier temporaire créé pour le push: $TEMP_PUSH_DIR"
    
    # Clone du dépôt pour le push (sans afficher le token)
    echo "Clonage du dépôt pour le push..."
    git clone --depth 1 "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPO}.git" "$TEMP_PUSH_DIR/repo" > /dev/null 2>&1
    
    if [ $? -ne 0 ]; then
        echo "$(date): ERREUR - Impossible de cloner le dépôt pour le push."
        rm -rf "$TEMP_PUSH_DIR"
    else
        # Copie des fichiers locaux vers le clone pour comparer
        cp -r "$SOURCE_DIR/"* "$TEMP_PUSH_DIR/repo/" 2>/dev/null
        
        # Vérification des changements
        cd "$TEMP_PUSH_DIR/repo"
        git add -A > /dev/null 2>&1
        
        if git diff-index --quiet HEAD --; then
            echo "$(date): Aucun changement local détecté, rien à pousser vers GitHub."
        else
            echo "$(date): Modifications locales détectées, préparation du push..."
            
            # Configuration Git
            git config user.name "Replit-Auto-Sync"
            git config user.email "replit-auto-sync@example.com"
            
            # Commit des changements
            git commit -m "Synchronisation automatique depuis Replit [$(date)]" > /dev/null 2>&1
            
            # Push vers GitHub (sans afficher le token)
            echo "Push vers GitHub..."
            git push origin "$BRANCH" > /dev/null 2>&1
            
            if [ $? -eq 0 ]; then
                echo "$(date): Push réussi - Les modifications locales ont été envoyées vers GitHub."
            else
                echo "$(date): ERREUR - Échec du push vers GitHub."
            fi
        fi
        
        # Nettoyage
        cd - > /dev/null 2>&1
    fi
    
    # Suppression du dossier temporaire
    rm -rf "$TEMP_PUSH_DIR"
else
    echo "$(date): Le token GitHub n'est pas disponible, skip de l'étape push vers GitHub."
fi

echo "==============================================="
echo "$(date): Synchronisation GitHub terminée"
echo "==============================================="