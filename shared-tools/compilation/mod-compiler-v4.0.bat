@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title Kraphtea Mod Compiler v4.0
cd /d "%~dp0"

:menu
cls
color 0A
echo [92m===============================================[0m
echo [96m           KRAPHTEA MOD COMPILER v4.0[0m
echo [92m===============================================[0m
echo.
echo Dossier actuel: %CD%
echo.

:: Détection automatique des mods
echo [93mScan des mods disponibles...[0m
set mod_count=0

:: Recherche dans MODs-released
if exist "..\..\mods\MODs-released" (
    echo [92m[OK][0m Dossier MODs-released accessible
    for /d %%d in ("..\..\mods\MODs-released\*") do (
        if exist "%%d\build.gradle" (
            set /a mod_count+=1
            set "mod_name_!mod_count!=%%~nxd"
            set "mod_path_!mod_count!=%%d"
            set "mod_type_!mod_count!=released"
            echo   [94m!mod_count!.[0m [97m%%~nxd[0m [92m[RELEASED][0m
        )
    )
) else (
    echo [91m[ERREUR][0m Dossier MODs-released non trouvé
)

:: Recherche dans MODs-in-progress
if exist "..\..\mods\MODs-in-progress" (
    echo [92m[OK][0m Dossier MODs-in-progress accessible
    for /d %%d in ("..\..\mods\MODs-in-progress\*") do (
        if exist "%%d\build.gradle" (
            set /a mod_count+=1
            set "mod_name_!mod_count!=%%~nxd"
            set "mod_path_!mod_count!=%%d"
            set "mod_type_!mod_count!=in-progress"
            echo   [94m!mod_count!.[0m [97m%%~nxd[0m [93m[IN-PROGRESS][0m
        )
    )
) else (
    echo [91m[ERREUR][0m Dossier MODs-in-progress non trouvé
)

echo.
echo [95mTotal mods détectés: [97m!mod_count![0m
echo.
echo [92m===============================================[0m
echo [96mOptions:[0m
echo [94m1.[0m Compiler un mod spécifique
echo [94m2.[0m Compiler tous les mods ([97m!mod_count![0m projets)
echo [94m3.[0m Vérifier l'environnement
echo [94m4.[0m Retour au menu principal
echo [94m5.[0m Quitter
echo [92m===============================================[0m
echo.
set /p choix=Votre choix (1-5): 

if "%choix%"=="1" goto select_mod
if "%choix%"=="2" goto compile_all
if "%choix%"=="3" goto check_env
if "%choix%"=="4" goto return_main
if "%choix%"=="5" goto quit

echo Choix invalide. Utilisez 1-5.
echo Appuyez sur une touche pour continuer...
pause >nul
goto menu

:select_mod
cls
color 0B
echo [96m===============================================[0m
echo [97m        SÉLECTION DU MOD À COMPILER[0m
echo [96m===============================================[0m
echo.
if !mod_count!==0 (
    echo Aucun mod détecté avec build.gradle!
    echo Appuyez sur une touche pour continuer...
    pause >nul
    goto menu
)

echo [93mMods disponibles:[0m
for /l %%i in (1,1,!mod_count!) do (
    if "!mod_type_%%i!"=="released" (
        echo   [94m%%i.[0m [97m!mod_name_%%i![0m [92m[!mod_type_%%i!][0m
    ) else (
        echo   [94m%%i.[0m [97m!mod_name_%%i![0m [93m[!mod_type_%%i!][0m
    )
)
echo.
set /p mod_choice=Sélectionnez le mod à compiler (1-!mod_count!): 

if !mod_choice! leq 0 goto invalid_choice
if !mod_choice! gtr !mod_count! goto invalid_choice

set "selected_name=!mod_name_%mod_choice%!"
set "selected_path=!mod_path_%mod_choice%!"
set "selected_type=!mod_type_%mod_choice%!"

echo.
echo [96m===============================================[0m
echo [97m       COMPILATION DE !selected_name![0m
echo [96m===============================================[0m
echo [93mType:[0m [95m!selected_type![0m
echo [93mChemin:[0m [90m!selected_path![0m
echo.

cd "!selected_path!"
if exist "build.gradle" (
    echo [93mCompilation en cours...[0m
    call gradlew build
    if exist "build\libs" (
        echo.
        echo [92m[SUCCESS][0m [97m!selected_name![0m [92mcompilé avec succès![0m
        echo [93mFichiers générés dans:[0m [95mbuild\libs\[0m
        echo.
        dir build\libs\*.jar /b 2>nul
    ) else (
        echo [91m[ERROR][0m [97mÉchec de la compilation de !selected_name!.[0m
    )
) else (
    echo [91m[ERROR][0m [97mFichier build.gradle non trouvé![0m
)

cd "%~dp0"
echo.
echo Appuyez sur une touche pour continuer...
pause >nul
goto menu

:invalid_choice
echo Choix invalide.
echo Appuyez sur une touche pour continuer...
pause >nul
goto menu

:compile_all
cls
color 0E
echo [93m===============================================[0m
echo [97m       COMPILATION DE TOUS LES MODS[0m
echo [93m===============================================[0m
echo.
if !mod_count!==0 (
    echo Aucun mod détecté!
    echo Appuyez sur une touche pour continuer...
    pause >nul
    goto menu
)

echo Compilation de !mod_count! mods...
echo.

:: Compilation de tous les mods dans MODs-released
if exist "..\..\mods\MODs-released" (
    for /d %%d in ("..\..\mods\MODs-released\*") do (
        if exist "%%d\build.gradle" (
            echo.
            echo Compilation de: %%~nxd [RELEASED]
            cd "%%d"
            call gradlew build
            if exist "build\libs" (
                echo [SUCCESS] %%~nxd compilé!
            ) else (
                echo [ERROR] Échec %%~nxd.
            )
            cd "%~dp0"
        )
    )
)

:: Compilation de tous les mods dans MODs-in-progress
if exist "..\..\mods\MODs-in-progress" (
    for /d %%d in ("..\..\mods\MODs-in-progress\*") do (
        if exist "%%d\build.gradle" (
            echo.
            echo Compilation de: %%~nxd [IN-PROGRESS]
            cd "%%d"
            call gradlew build
            if exist "build\libs" (
                echo [SUCCESS] %%~nxd compilé!
            ) else (
                echo [ERROR] Échec %%~nxd.
            )
            cd "%~dp0"
        )
    )
)

echo.
echo ===============================================
echo Compilation terminée. Vérifiez les résultats ci-dessus.
echo ===============================================
echo.
echo Appuyez sur une touche pour continuer...
pause >nul
goto menu

:check_env
cls
color 0C
echo [95m===============================================[0m
echo [97m       VÉRIFICATION DE L'ENVIRONNEMENT[0m
echo [95m===============================================[0m
echo.

echo Test: Java...
java -version 2>nul
if errorlevel 1 (
    echo [ERREUR] Java non trouvé ou non installé!
) else (
    echo [OK] Java installé.
)
echo.

echo Test: Gradle...
gradle --version >nul 2>nul
if errorlevel 1 (
    echo [ERREUR] Gradle non trouvé ou non installé!
) else (
    echo [OK] Gradle installé.
)
echo.

echo Test: Structure des dossiers...
if exist "..\..\mods\MODs-released" (
    echo [OK] Dossier MODs-released trouvé.
) else (
    echo [ERREUR] Dossier MODs-released non trouvé!
)

if exist "..\..\mods\MODs-in-progress" (
    echo [OK] Dossier MODs-in-progress trouvé.
) else (
    echo [ERREUR] Dossier MODs-in-progress non trouvé!
)
echo.

echo Test: Mods détectés...
set found_mods=0

if exist "..\..\mods\MODs-released" (
    for /d %%d in ("..\..\mods\MODs-released\*") do (
        if exist "%%d\build.gradle" (
            echo [OK] %%~nxd (released)
            set /a found_mods+=1
        )
    )
)

if exist "..\..\mods\MODs-in-progress" (
    for /d %%d in ("..\..\mods\MODs-in-progress\*") do (
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