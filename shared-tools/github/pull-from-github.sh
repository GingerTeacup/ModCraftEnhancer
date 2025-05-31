#!/bin/bash

# Script pour récupérer uniquement les modifications des pull requests acceptées
# Usage: ./pull-from-github.sh

# Configuration
GITHUB_REPO="GingerTeacup/ModCraftEnhancer"
SOURCE_DIR="kraphtea-mods"
BRANCH="main"
LAST_COMMIT_FILE=".last_synced_commit"

echo "==============================================="
echo "  Récupération des modifications depuis GitHub"
echo "  Dépôt source: $GITHUB_REPO"
echo "  Synchronisation sélective des pull requests"
echo "==============================================="

# Vérification du token GitHub
if [ -z "${GITHUB_TOKEN}" ]; then
    echo "AVERTISSEMENT: Le token GitHub n'est pas défini dans l'environnement."
    echo "Les opérations anonymes peuvent être limitées par GitHub."
    echo "Pour définir le token: export GITHUB_TOKEN=\"votre_token\""
fi

# Création d'un dossier temporaire
TEMP_DIR=$(mktemp -d)
echo "Dossier temporaire créé: $TEMP_DIR"

# Clone du dépôt GitHub avec historique complet
echo "Clonage du dépôt $GITHUB_REPO..."
if [ -n "${GITHUB_TOKEN}" ]; then
    # Utilisation du token si disponible
    git clone "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPO}.git" "$TEMP_DIR/repo" || {
        echo "Erreur: Impossible de cloner le dépôt avec le token."
        echo "Tentative de clonage anonyme..."
        git clone "https://github.com/${GITHUB_REPO}.git" "$TEMP_DIR/repo" || {
            echo "Erreur: Impossible de cloner le dépôt."
            exit 1
        }
    }
else
    # Clone anonyme
    git clone "https://github.com/${GITHUB_REPO}.git" "$TEMP_DIR/repo" || {
        echo "Erreur: Impossible de cloner le dépôt."
        exit 1
    }
fi

# Vérification si le dossier source existe localement
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Le dossier $SOURCE_DIR n'existe pas localement, création..."
    mkdir -p "$SOURCE_DIR"
    # Premier clonage, enregistrer le commit actuel et copier tous les fichiers
    cd "$TEMP_DIR/repo"
    CURRENT_COMMIT=$(git rev-parse HEAD)
    echo "$CURRENT_COMMIT" > "../../$LAST_COMMIT_FILE"
    
    echo "Première synchronisation - copie complète des fichiers..."
    cd ../..
    cp -r "$TEMP_DIR/repo/"* ./ || {
        echo "Erreur lors de la copie des fichiers."
        exit 1
    }
    
    echo "Synchronisation initiale terminée."
    rm -rf "$TEMP_DIR"
    exit 0
fi

# Récupérer le dernier commit synchronisé
LAST_COMMIT=""
if [ -f "$LAST_COMMIT_FILE" ]; then
    LAST_COMMIT=$(cat "$LAST_COMMIT_FILE")
    echo "Dernier commit synchronisé: ${LAST_COMMIT:0:7}..."
else
    echo "Aucun commit précédemment synchronisé trouvé."
    echo "Synchronisation complète requise..."
    
    # Enregistrer le commit actuel
    cd "$TEMP_DIR/repo"
    CURRENT_COMMIT=$(git rev-parse HEAD)
    echo "$CURRENT_COMMIT" > "../../$LAST_COMMIT_FILE"
    
    # Copie des fichiers depuis le dépôt cloné
    cd ../..
    cp -r "$TEMP_DIR/repo/"* ./ || {
        echo "Erreur lors de la copie des fichiers."
        exit 1
    }
    
    echo "Synchronisation initiale terminée."
    rm -rf "$TEMP_DIR"
    exit 0
fi

# Vérifier s'il y a des nouvelles pull requests fusionnées depuis le dernier commit
cd "$TEMP_DIR/repo"
echo "Analyse des pull requests fusionnées depuis la dernière synchronisation..."

# Sauvegarde des fichiers qui ne doivent pas être écrasés
echo "Sauvegarde des fichiers locaux spécifiques..."
BACKUP_DIR=$(mktemp -d)
if [ -f "../../$SOURCE_DIR/config.local.json" ]; then
   cp "../../$SOURCE_DIR/config.local.json" "$BACKUP_DIR/"
fi
if [ -d "../../$SOURCE_DIR/local-data" ]; then
   cp -r "../../$SOURCE_DIR/local-data" "$BACKUP_DIR/"
fi

# Identifier les fichiers modifiés par des pull requests depuis le dernier commit
CHANGED_FILES=$(git diff --name-only "$LAST_COMMIT" HEAD | grep -v "^$SOURCE_DIR/local-data" | grep -v "config.local.json")

if [ -z "$CHANGED_FILES" ]; then
    echo "Aucune modification trouvée depuis la dernière synchronisation."
    echo "Aucune action requise."
else
    echo "Fichiers modifiés trouvés. Synchronisation sélective..."
    echo "Fichiers à synchroniser:"
    echo "$CHANGED_FILES"
    
    # Synchroniser uniquement les fichiers modifiés
    for file in $CHANGED_FILES; do
        # Créer le dossier de destination si nécessaire
        dir_path="../../$(dirname $file)"
        if [ ! -d "$dir_path" ]; then
            mkdir -p "$dir_path"
        fi
        
        # Copier le fichier s'il existe
        if [ -f "$file" ]; then
            cp "$file" "../../$file" || {
                echo "Erreur lors de la copie du fichier: $file"
            }
            echo "Synchronisé: $file"
        fi
    done
    
    # Restauration des fichiers sauvegardés
    echo "Restauration des fichiers locaux spécifiques..."
    if [ -f "$BACKUP_DIR/config.local.json" ]; then
        cp "$BACKUP_DIR/config.local.json" "../../$SOURCE_DIR/"
    fi
    if [ -d "$BACKUP_DIR/local-data" ]; then
        cp -r "$BACKUP_DIR/local-data" "../../$SOURCE_DIR/"
    fi
    
    # Mise à jour du dernier commit synchronisé
    CURRENT_COMMIT=$(git rev-parse HEAD)
    echo "$CURRENT_COMMIT" > "../../$LAST_COMMIT_FILE"
fi

cd ../..

echo "==============================================="
echo "  Mise à jour depuis GitHub terminée"
echo "  Dépôt: $GITHUB_REPO"
echo "  Branche: $BRANCH"
echo "==============================================="

# Nettoyage
rm -rf "$TEMP_DIR" "$BACKUP_DIR"
echo "Nettoyage terminé."