@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
cd /d "%~dp0"

REM =================================================
REM Menu principal des outils Kraphtea Mods
REM Version 2.0
REM =================================================

:MAIN_MENU
cls
color 0A
echo.
echo [92m=====================================================[0m
echo [96m     KRAPHTEA MODS - OUTILS DE DÉVELOPPEMENT v2.0[0m
echo [92m=====================================================[0m
echo.
echo [93mDossier actuel :[0m [90m%CD%[0m
echo.
echo [93mSélectionnez une option :[0m
echo.
echo  [94m1.[0m [97mMenu de compilation de mods[0m
echo  [94m2.[0m [97mCréer un nouveau mod[0m
echo  [94m3.[0m [97mSynchroniser avec GitHub[0m
echo  [94m4.[0m [97mDocumentation[0m
echo  [94m5.[0m [97mQuitter[0m
echo.

set /p MENU_CHOICE="[95mVotre choix (1-5) :[0m "

if "%MENU_CHOICE%"=="1" (
    echo [93mLancement du menu de compilation...[0m
    if exist "compilation\mod-compiler-v4.0.bat" (
        call "compilation\mod-compiler-v4.0.bat"
    ) else (
        echo [91m[ERREUR][0m Fichier de compilation non trouvé!
        echo [90mChemin recherché : compilation\mod-compiler-v4.0.bat[0m
        pause
    )
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
    echo [96mAu revoir ![0m
    timeout /t 2 >nul
    goto :EOF
) else (
    echo.
    echo [91m[ERREUR][0m Option invalide. Appuyez sur une touche pour réessayer...
    pause > nul
    goto MAIN_MENU
)

:CREATE_MOD_MENU
cls
color 0B
echo.
echo [96m=====================================================[0m
echo [97m     CRÉATION D'UN NOUVEAU MOD[0m
echo [96m=====================================================[0m
echo.
echo [93mEntrez le nom du nouveau mod:[0m
echo [90m(Utilisez des underscores pour séparer les mots, ex: awesome_mod)[0m
echo.

set /p MOD_NAME="[95mNom du mod:[0m "

if "%MOD_NAME%"=="" (
    echo.
    echo [91m[ERREUR][0m Le nom du mod ne peut pas être vide.
    echo [93mAppuyez sur une touche pour revenir au menu...[0m
    pause > nul
    exit /b
)

echo.
echo [93mVous allez créer un nouveau mod nommé:[0m [97m%MOD_NAME%[0m
echo.
echo [95mConfirmez-vous la création? (O/N)[0m
set /p CONFIRM="[95mVotre choix:[0m "

if /i "%CONFIRM%"=="O" (
    echo.
    echo [93mCréation du mod en cours...[0m
    if exist "mod-creator-v2.0.bat" (
        call "mod-creator-v2.0.bat" %MOD_NAME%
    ) else (
        echo [91m[ERREUR][0m Script de création non trouvé!
    )
    echo.
    echo [93mAppuyez sur une touche pour revenir au menu principal...[0m
    pause > nul
) else (
    echo.
    echo [90mCréation annulée.[0m
    echo.
    echo [93mAppuyez sur une touche pour revenir au menu principal...[0m
    pause > nul
)
exit /b

:GITHUB_MENU
cls
color 0E
echo.
echo [93m=====================================================[0m
echo [97m     SYNCHRONISATION AVEC GITHUB[0m
echo [93m=====================================================[0m
echo.
echo [95mOptions de synchronisation:[0m
echo.
echo  [94m1.[0m [97mRécupérer les modifications depuis GitHub[0m
echo  [94m2.[0m [97mEnvoyer les modifications vers GitHub[0m
echo  [94m3.[0m [97mRetour au menu principal[0m
echo.

set /p GITHUB_CHOICE="[95mVotre choix (1-3) :[0m "

if "%GITHUB_CHOICE%"=="1" (
    echo.
    echo [93mRécupération des modifications depuis GitHub...[0m
    cd ..
    call pull-from-github.sh
    cd shared-tools
    echo.
    echo [92mSynchronisation terminée.[0m
    echo [93mAppuyez sur une touche pour continuer...[0m
    pause > nul
    exit /b
) else if "%GITHUB_CHOICE%"=="2" (
    echo.
    echo [93mEnvoi des modifications vers GitHub...[0m
    cd ..
    call replit-github-sync-workflow.sh
    cd shared-tools
    echo.
    echo [92mSynchronisation terminée.[0m
    echo [93mAppuyez sur une touche pour continuer...[0m
    pause > nul
    exit /b
) else if "%GITHUB_CHOICE%"=="3" (
    exit /b
) else (
    echo.
    echo [91m[ERREUR][0m Option invalide. Appuyez sur une touche pour réessayer...
    pause > nul
    goto GITHUB_MENU
)

:SHOW_DOCUMENTATION
cls
color 0C
echo.
echo [95m=====================================================[0m
echo [97m     DOCUMENTATION KRAPHTEA MODS v2.0[0m
echo [95m=====================================================[0m
echo.
echo [96mSTRUCTURE DU PROJET :[0m
echo [90m--------------------[0m
echo [97mChaque mod est contenu dans son propre dossier et peut être compilé[0m
echo [97mséparément. Les outils communs sont partagés via le dossier shared-tools.[0m
echo.
echo [96mCOMPILATION :[0m
echo [90m-----------[0m
echo [97m1. Utilisez le menu de compilation pour compiler un ou plusieurs mods[0m
echo [97m2. Les fichiers JAR compilés se trouvent dans build/libs/ de chaque mod[0m
echo.
echo [96mCRÉATION DE MOD :[0m
echo [90m--------------[0m
echo [97m1. Utilisez l'option "Créer un nouveau mod" du menu principal[0m
echo [97m2. Entrez un nom (utilisez des underscores pour séparer les mots)[0m
echo [97m3. Le système créera automatiquement la structure de base du mod[0m
echo.
echo [96mSYNCHRONISATION GITHUB :[0m
echo [90m--------------------[0m
echo [97m1. Option "Synchroniser avec GitHub" pour envoyer/recevoir des mises à jour[0m
echo [97m2. Utilise les scripts de synchronisation automatique configurés[0m
echo.
echo [96mEXIGENCES TECHNIQUES :[0m
echo [90m-------------------[0m
echo [97m- Java JDK 17 ou supérieur[0m
echo [97m- Minecraft 1.20.1[0m
echo [97m- Fabric API[0m
echo.
echo [93mAppuyez sur une touche pour revenir au menu principal...[0m
pause > nul
exit /b 0