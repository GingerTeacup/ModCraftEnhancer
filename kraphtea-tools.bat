@echo off
setlocal enabledelayedexpansion

REM =================================================
REM Menu principal des outils Kraphtea Mods
REM Version 2.0
REM =================================================

:MAIN_MENU
cls
echo.
echo =====================================================
echo     KRAPHTEA MODS - OUTILS DE DÉVELOPPEMENT v2.0
echo =====================================================
echo.
echo Sélectionnez une option :
echo.
echo  1. Menu de compilation de mods
echo  2. Créer un nouveau mod
echo  3. Synchroniser avec GitHub
echo  4. Documentation
echo  5. Quitter
echo.

set /p MENU_CHOICE="Votre choix (1-5) : "

if "%MENU_CHOICE%"=="1" (
    call "shared-tools\compilation\compiler-menu.bat"
    goto MAIN_MENU
) else if "%MENU_CHOICE%"=="2" (
    call :CREATE_MOD_MENU
    goto MAIN_MENU
) else if "%MENU_CHOICE%"=="3" (
    call :GITHUB_MENU
    goto MAIN_MENU
) else if "%MENU_CHOICE%"=="4" (
    call :SHOW_DOCUMENTATION
    goto MAIN_MENU
) else if "%MENU_CHOICE%"=="5" (
    echo.
    echo Au revoir !
    goto :EOF
) else (
    echo.
    echo [ERREUR] Option invalide. Appuyez sur une touche pour réessayer...
    pause > nul
    goto MAIN_MENU
)

:CREATE_MOD_MENU
cls
echo.
echo =====================================================
echo     CRÉATION D'UN NOUVEAU MOD
echo =====================================================
echo.
echo Entrez le nom du nouveau mod:
echo (Utilisez des underscores pour séparer les mots, ex: awesome_mod)
echo.

set /p MOD_NAME="Nom du mod: "

if "%MOD_NAME%"=="" (
    echo.
    echo [ERREUR] Le nom du mod ne peut pas être vide.
    echo Appuyez sur une touche pour revenir au menu...
    pause > nul
    exit /b
)

echo.
echo Vous allez créer un nouveau mod nommé: %MOD_NAME%
echo.
echo Confirmez-vous la création? (O/N)
set /p CONFIRM="Votre choix: "

if /i "%CONFIRM%"=="O" (
    echo.
    echo Création du mod en cours...
    call "shared-tools\create-new-mod.bat" %MOD_NAME%
    echo.
    echo Appuyez sur une touche pour revenir au menu principal...
    pause > nul
) else (
    echo.
    echo Création annulée.
    echo.
    echo Appuyez sur une touche pour revenir au menu principal...
    pause > nul
)
exit /b

:GITHUB_MENU
cls
echo.
echo =====================================================
echo     SYNCHRONISATION AVEC GITHUB
echo =====================================================
echo.
echo Options de synchronisation:
echo.
echo  1. Récupérer les modifications depuis GitHub
echo  2. Envoyer les modifications vers GitHub
echo  3. Retour au menu principal
echo.

set /p GITHUB_CHOICE="Votre choix (1-3) : "

if "%GITHUB_CHOICE%"=="1" (
    echo.
    echo Récupération des modifications depuis GitHub...
    cd ..
    call pull-from-github.sh
    cd kraphtea-mods
    echo.
    echo Synchronisation terminée.
    echo Appuyez sur une touche pour continuer...
    pause > nul
    exit /b
) else if "%GITHUB_CHOICE%"=="2" (
    echo.
    echo Envoi des modifications vers GitHub...
    cd ..
    call push-to-github.sh
    cd kraphtea-mods
    echo.
    echo Synchronisation terminée.
    echo Appuyez sur une touche pour continuer...
    pause > nul
    exit /b
) else if "%GITHUB_CHOICE%"=="3" (
    exit /b
) else (
    echo.
    echo [ERREUR] Option invalide. Appuyez sur une touche pour réessayer...
    pause > nul
    goto GITHUB_MENU
)

:SHOW_DOCUMENTATION
cls
echo.
echo =====================================================
echo     DOCUMENTATION KRAPHTEA MODS
echo =====================================================
echo.
echo STRUCTURE DU PROJET :
echo --------------------
echo Chaque mod est contenu dans son propre dossier et peut être compilé
echo séparément. Les outils communs sont partagés via le dossier shared-tools.
echo.
echo COMPILATION :
echo -----------
echo 1. Utilisez le menu de compilation pour compiler un ou plusieurs mods
echo 2. Les fichiers JAR compilés se trouvent dans le dossier build/libs/ de chaque mod
echo.
echo CRÉATION DE MOD :
echo --------------
echo 1. Utilisez l'option "Créer un nouveau mod" du menu principal
echo 2. Entrez un nom pour votre mod (utilisez des underscores pour séparer les mots)
echo 3. Le système créera automatiquement la structure de base du mod
echo.
echo SYNCHRONISATION GITHUB :
echo --------------------
echo 1. Utilisez l'option "Synchroniser avec GitHub" pour envoyer ou recevoir des mises à jour
echo 2. Pour utiliser les fonctionnalités avancées, définissez GITHUB_TOKEN dans les variables d'environnement
echo.
echo EXIGENCES TECHNIQUES :
echo -------------------
echo - Java JDK 17 ou supérieur
echo - Minecraft 1.20.1
echo - Fabric API
echo.
echo Appuyez sur une touche pour revenir au menu principal...
pause > nul
exit /b 0