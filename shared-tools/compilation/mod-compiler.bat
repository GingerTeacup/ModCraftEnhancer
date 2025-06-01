@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title Kraphtea Mod Compiler v2.5
cd /d "%~dp0"

REM ===============================================
REM     Kraphtea Mods - Compilateur de mods
REM     Version: v2.5
REM ===============================================

:menu
cls
echo.
echo ===============================================
echo           KRAPHTEA MOD COMPILER v2.5
echo ===============================================
echo.
echo Dossier actuel: %CD%
echo.

:: Detection automatique des mods
echo Scan des mods disponibles...
set mod_count=0

:: Recherche dans MODs-released
if exist "..\..\mods\MODs-released" (
    echo [OK] Dossier MODs-released accessible
    for /d %%d in ("..\..\mods\MODs-released\*") do (
        if exist "%%d\build.gradle" (
            set /a mod_count+=1
            set "mod_name_!mod_count!=%%~nxd"
            set "mod_path_!mod_count!=%%d"
            set "mod_type_!mod_count!=released"
            echo   !mod_count!. %%~nxd [RELEASED]
        )
    )
) else (
    echo [ERREUR] Dossier MODs-released non trouve
)

:: Recherche dans MODs-in-progress
if exist "..\..\mods\MODs-in-progress" (
    echo [OK] Dossier MODs-in-progress accessible
    for /d %%d in ("..\..\mods\MODs-in-progress\*") do (
        if exist "%%d\build.gradle" (
            set /a mod_count+=1
            set "mod_name_!mod_count!=%%~nxd"
            set "mod_path_!mod_count!=%%d"
            set "mod_type_!mod_count!=in-progress"
            echo   !mod_count!. %%~nxd [IN-PROGRESS]
        )
    )
) else (
    echo [ERREUR] Dossier MODs-in-progress non trouve
)

echo.
echo Total mods detectes: !mod_count!
echo.
echo ===============================================
echo Options:
echo 1. Compiler un mod specifique
echo 2. Compiler tous les mods (!mod_count! projets)
echo 3. Verifier l'environnement
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
echo Appuyez sur une touche pour continuer...
pause >nul
goto menu

:select_mod
cls
echo ===============================================
echo        SELECTION DU MOD A COMPILER
echo ===============================================
echo.
if !mod_count!==0 (
    echo Aucun mod detecte avec build.gradle!
    echo Appuyez sur une touche pour continuer...
    pause >nul
    goto menu
)

echo Mods disponibles:
for /l %%i in (1,1,!mod_count!) do (
    echo   %%i. !mod_name_%%i! [!mod_type_%%i!]
)
echo.
set /p mod_choice=Selectionnez le mod a compiler (1-!mod_count!): 

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
        echo [SUCCESS] !selected_name! compile avec succes!
        echo Fichiers generes dans: build\libs\
        echo.
        dir build\libs\*.jar /b 2>nul
    ) else (
        echo [ERROR] Echec de la compilation de !selected_name!.
    )
) else (
    echo [ERROR] Fichier build.gradle non trouve!
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
echo ===============================================
echo       COMPILATION DE TOUS LES MODS
echo ===============================================
echo.
if !mod_count!==0 (
    echo Aucun mod detecte!
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
                echo [SUCCESS] %%~nxd compile!
            ) else (
                echo [ERROR] Echec %%~nxd.
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
                echo [SUCCESS] %%~nxd compile!
            ) else (
                echo [ERROR] Echec %%~nxd.
            )
            cd "%~dp0"
        )
    )
)

echo.
echo ===============================================
echo Compilation terminee. Verifiez les resultats ci-dessus.
echo ===============================================
echo.
echo Appuyez sur une touche pour continuer...
pause >nul
goto menu

:check_env
cls
echo ===============================================
echo       VERIFICATION DE L'ENVIRONNEMENT
echo ===============================================
echo.

echo Test: Java...
java -version >nul 2>&1
if errorlevel 1 (
    echo [ERREUR] Java non trouve ou non installe!
) else (
    echo [OK] Java installe.
)
echo.

echo Test: Gradle...
gradle --version >nul 2>&1
if errorlevel 1 (
    echo [ERREUR] Gradle non trouve ou non installe!
) else (
    echo [OK] Gradle installe.
)
echo.

echo Test: Structure des dossiers...
if exist "..\..\mods\MODs-released" (
    echo [OK] Dossier MODs-released trouve.
) else (
    echo [ERREUR] Dossier MODs-released non trouve!
)

if exist "..\..\mods\MODs-in-progress" (
    echo [OK] Dossier MODs-in-progress trouve.
) else (
    echo [ERREUR] Dossier MODs-in-progress non trouve!
)
echo.

echo Test: Mods detectes...
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
echo Verification terminee.
echo ===============================================
echo.
echo Appuyez sur une touche pour revenir au menu...
pause >nul
goto menu

:return_main
cd ..
call kraphtea-main.bat
exit

:quit
echo.
echo Au revoir!
timeout /t 2 >nul
exit