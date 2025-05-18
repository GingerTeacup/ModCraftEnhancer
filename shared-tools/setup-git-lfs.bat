@echo off
setlocal enabledelayedexpansion

REM ===============================================
REM     Configuration de Git LFS pour Kraphtea-Mods
REM     Version: 1.0.0
REM ===============================================

echo ===============================================
echo     Configuration de Git LFS
echo ===============================================
echo.

REM Vérification de l'installation de Git LFS
echo [1/5] Vérification de l'installation de Git LFS...
git lfs version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERREUR] Git LFS n'est pas installé ou n'est pas dans le PATH
    echo Veuillez installer Git LFS depuis https://git-lfs.github.com/
    echo puis exécuter 'git lfs install' avant de relancer ce script.
    exit /b 1
)

echo Git LFS est correctement installé.
echo.

REM Initialisation de Git LFS
echo [2/5] Initialisation de Git LFS...
git lfs install

if %ERRORLEVEL% NEQ 0 (
    echo [ERREUR] Échec de l'initialisation de Git LFS
    exit /b 1
)
echo.

REM Configuration du tracking des fichiers
echo [3/5] Configuration du tracking des fichiers...

echo Suivi des fichiers JAR...
git lfs track "*.jar"

echo Suivi des fichiers PNG...
git lfs track "*.png"

echo Suivi des fichiers ZIP...
git lfs track "*.zip"

echo Suivi des fichiers de modèles...
git lfs track "*.blend"
git lfs track "*.obj"
git lfs track "*.fbx"

echo.

REM Mise à jour du .gitattributes
echo [4/5] Mise à jour du fichier .gitattributes...
git add .gitattributes

echo Contenu actuel du fichier .gitattributes:
type .gitattributes
echo.

REM Instructions pour l'utilisateur
echo [5/5] Configuration terminée!
echo.
echo ===============================================
echo     INSTRUCTIONS POUR GIT LFS
echo ===============================================
echo.
echo La configuration de Git LFS est terminée. Voici comment l'utiliser:
echo.
echo 1. Pour ajouter et committer des fichiers comme d'habitude:
echo    git add .
echo    git commit -m "Votre message de commit"
echo.
echo 2. Pour pousser vos modifications incluant des fichiers LFS:
echo    git push origin main
echo.
echo 3. Si vous avez déjà des fichiers JAR/PNG/ZIP dans le dépôt:
echo    git lfs migrate import --include="*.jar,*.png,*.zip" --everything
echo    git push -f origin main
echo.
echo 4. Pour vérifier le statut de Git LFS:
echo    git lfs status
echo.
echo Pour plus d'informations, consultez le guide détaillé:
echo docs/git-lfs-guide.md
echo.
echo ===============================================

exit /b 0