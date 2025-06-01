@echo off
setlocal enabledelayedexpansion
title Kraphtea Mod Compiler - Détection Automatique
cd /d "%~dp0"

:menu
cls
echo ===============================================
echo           KRAPHTEA MOD COMPILER
echo           DÉTECTION AUTOMATIQUE
echo ===============================================
echo.
echo Dossier actuel: %CD%
echo.

:: Détection automatique des mods
echo Scan des mods disponibles...
set mod_count=0
set mod_list=

:: Recherche dans MODs-released
if exist "..\mods\MODs-released" (
    for /d %%d in ("..\mods\MODs-released\*") do (
        if exist "%%d\build.gradle" (
            set /a mod_count+=1
            set "mod_name_!mod_count!=%%~nxd"
            set "mod_path_!mod_count!=%%d"
            set "mod_type_!mod_count!=released"
            echo   !mod_count!. %%~nxd [RELEASED]
        )
    )
)

:: Recherche dans MODs-in-progress  
if exist "..\mods\MODs-in-progress" (
    for /d %%d in ("..\mods\MODs-in-progress\*") do (
        if exist "%%d\build.gradle" (
            set /a mod_count+=1
            set "mod_name_!mod_count!=%%~nxd"
            set "mod_path_!mod_count!=%%d"
            set "mod_type_!mod_count!=in-progress"
            echo   !mod_count!. %%~nxd [IN-PROGRESS]
        )
    )
)

echo.
echo Total mods détectés: !mod_count!
echo.
echo ===============================================
echo Options:
echo 1. Compiler un mod spécifique
echo 2. Compiler tous les mods (!mod_count! projets)
echo 3. Vérifier l'environnement
echo 4. Retour au menu principal
echo 5. Quitter
echo ===============================================
echo.
set /p choix=Votre choix (1-5): 

if "%choix%"=="1" goto select_mod
if "%choix%"=="2" goto compile_all
if "%choix%"=="3" goto check_env
if "%choix%"=="4" goto return_main
if "%choix%"=="5" goto quit

echo Choix invalide. Utilisez 1-5.
pause
goto menu

:select_mod
cls
echo ===============================================
echo        SÉLECTION DU MOD À COMPILER
echo ===============================================
echo.
if !mod_count!==0 (
    echo Aucun mod détecté avec build.gradle!
    pause
    goto menu
)

echo Mods disponibles:
for /l %%i in (1,1,!mod_count!) do (
    echo   %%i. !mod_name_%%i! [!mod_type_%%i!]
)
echo.
set /p mod_choice=Sélectionnez le mod à compiler (1-!mod_count!): 

if !mod_choice! leq 0 goto invalid_choice
if !mod_choice! gtr !mod_count! goto invalid_choice

set "selected_name=!mod_name_%mod_choice%!"
set "selected_path=!mod_path_%mod_choice%!"
set "selected_type=!mod_type_%mod_choice%!"

echo.
echo ===============================================
echo       COMPILATION DE !selected_name!
echo ===============================================
echo Type: !selected_type!
echo Chemin: !selected_path!
echo.

cd "!selected_path!"
if exist "build.gradle" (
    echo Compilation en cours...
    call gradlew build
    if exist "build\libs" (
        echo.
        echo [SUCCESS] !selected_name! compilé avec succès!
        echo Fichiers générés dans: build\libs\
        echo.
        dir build\libs\*.jar /b
    ) else (
        echo [ERROR] Échec de la compilation de !selected_name!.
    )
) else (
    echo [ERROR] Fichier build.gradle non trouvé!
)

cd "%~dp0"
echo.
echo Appuyez sur une touche pour continuer...
pause >nul
goto menu

:invalid_choice
echo Choix invalide.
pause
goto menu

:compile_all
cls
echo ===============================================
echo       COMPILATION DE TOUS LES MODS
echo ===============================================
echo.
if !mod_count!==0 (
    echo Aucun mod détecté!
    pause
    goto menu
)

echo Compilation de !mod_count! mods...
echo.

for /l %%i in (1,1,!mod_count!) do (
    set "current_name=!mod_name_%%i!"
    set "current_path=!mod_path_%%i!"
    set "current_type=!mod_type_%%i!"
    
    echo -----------------------------------------------
    echo Compilation: !current_name! [!current_type!]
    echo -----------------------------------------------
    
    cd "!current_path!"
    if exist "build.gradle" (
        call gradlew build
        if exist "build\libs" (
            echo [SUCCESS] !current_name! compilé!
        ) else (
            echo [ERROR] Échec !current_name!.
        )
    ) else (
        echo [ERROR] !current_name!: build.gradle non trouvé!
    )
    cd "%~dp0"
    echo.
)

echo ===============================================
echo Compilation terminée. Vérifiez les résultats ci-dessus.
echo ===============================================
echo.
echo Appuyez sur une touche pour continuer...
pause >nul
goto menu

:check_env
cls
echo ===============================================
echo       VÉRIFICATION DE L'ENVIRONNEMENT
echo ===============================================
echo.

echo Test: Java...
java -version 2>nul
if !errorlevel!==0 (
    echo [OK] Java installé.
    java -version
) else (
    echo [ERREUR] Java non trouvé ou non installé!
)
echo.

echo Test: Gradle...
gradle --version 2>nul | findstr "Gradle" >nul
if !errorlevel!==0 (
    echo [OK] Gradle installé.
    for /f "tokens=*" %%a in ('gradle --version 2^>nul ^| findstr "Gradle"') do echo %%a
) else (
    echo [ERREUR] Gradle non trouvé ou non installé!
)
echo.

echo Test: Structure des dossiers...
if exist "..\mods\MODs-released" (
    echo [OK] Dossier MODs-released trouvé.
) else (
    echo [ERREUR] Dossier MODs-released non trouvé!
)

if exist "..\mods\MODs-in-progress" (
    echo [OK] Dossier MODs-in-progress trouvé.
) else (
    echo [ERREUR] Dossier MODs-in-progress non trouvé!
)
echo.

echo Test: Mods détectés...
set found_mods=0

if exist "..\mods\MODs-released" (
    for /d %%d in ("..\mods\MODs-released\*") do (
        if exist "%%d\build.gradle" (
            echo [OK] %%~nxd (released)
            set /a found_mods+=1
        )
    )
)

if exist "..\mods\MODs-in-progress" (
    for /d %%d in ("..\mods\MODs-in-progress\*") do (
        if exist "%%d\build.gradle" (
            echo [OK] %%~nxd (in-progress)
            set /a found_mods+=1
        )
    )
)

echo.
echo Total mods avec build.gradle: !found_mods!
echo.

echo ===============================================
echo Vérification terminée.
echo ===============================================
echo.
echo Appuyez sur une touche pour revenir au menu...
pause >nul
goto menu

:return_main
cd ..
call kraphtea-tools.bat
exit

:quit
echo.
echo Au revoir!
timeout /t 2 >nul
exit
