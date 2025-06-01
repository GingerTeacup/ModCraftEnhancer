@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
cd /d "%~dp0"

REM =================================================
REM Menu principal des outils Kraphtea Mods
REM Version: v2.3
REM =================================================

:MAIN_MENU
cls
echo.
echo =====================================================
echo      KRAPHTEA MODS - OUTILS DE DEVELOPPEMENT v2.5
echo =====================================================
echo.
echo Dossier actuel : %CD%
echo.
echo Selectionnez une option :
echo.
echo  1. Menu de compilation de mods
echo  2. Creer un nouveau mod
echo  3. Synchroniser avec GitHub
echo  4. Documentation
echo  5. Quitter
echo.

set /p MENU_CHOICE="Votre choix (1-5) : "

if "%MENU_CHOICE%"=="1" (
    echo Lancement du menu de compilation...
    if exist "compilation\mod-compiler.bat" (
        echo Fichier trouve, lancement...
        call "compilation\mod-compiler.bat"
        echo Retour du menu de compilation.
    ) else (
        echo ERREUR : Fichier de compilation non trouve !
        echo Chemin recherche : compilation\mod-compiler.bat
        echo Contenu du dossier compilation :
        dir compilation /b
        echo.
        echo Appuyez sur une touche pour continuer...
        pause
    )
    goto MAIN_MENU
) else if "%MENU_CHOICE%"=="2" (
    echo Lancement creation de mod...
    if exist "mod-creator.bat" (
        set /p MOD_NAME="Nom du nouveau mod : "
        call "mod-creator.bat" !MOD_NAME!
    ) else (
        echo ERREUR : Script de creation non trouve !
        echo Chemin recherche : mod-creator.bat
    )
    echo Appuyez sur une touche pour continuer...
    pause
    goto MAIN_MENU
) else if "%MENU_CHOICE%"=="3" (
    echo Synchronisation GitHub...
    if exist "..\replit-github-sync-workflow.sh" (
        cd ..
        call replit-github-sync-workflow.sh
        cd shared-tools
    ) else (
        echo ERREUR : Script GitHub non trouve !
    )
    echo Appuyez sur une touche pour continuer...
    pause
    goto MAIN_MENU
) else if "%MENU_CHOICE%"=="4" (
    echo.
    echo DOCUMENTATION KRAPHTEA MODS v2.5
    echo =================================
    echo.
    echo Structure du projet :
    echo - Chaque mod dans son propre dossier
    echo - Outils communs dans shared-tools
    echo - Compilation via menu option 1
    echo.
    echo Exigences :
    echo - Java JDK 17+
    echo - Minecraft 1.20.1
    echo - Fabric API
    echo.
    echo Appuyez sur une touche pour revenir au menu...
    pause
    goto MAIN_MENU
) else if "%MENU_CHOICE%"=="5" (
    echo.
    echo Au revoir !
    timeout /t 2 >nul
    exit
) else (
    echo.
    echo ERREUR : Option invalide. Utilisez 1-5.
    echo Appuyez sur une touche pour reessayer...
    pause
    goto MAIN_MENU
)

echo Script termine.
pause