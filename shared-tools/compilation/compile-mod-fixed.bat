@echo off
setlocal enabledelayedexpansion

REM =================================================
REM Script de compilation simplifié pour Kraphtea Mods
REM Version 2.0 (Fixe)
REM =================================================

title Compilateur Kraphtea Mods - Version Fixe

REM Déterminer le chemin absolu vers le dossier kraphtea-mods
set ROOT_DIR=%~dp0..\..
cd /d %ROOT_DIR%

:main_menu
cls
echo.
echo ===================================================
echo     COMPILATEUR KRAPHTEA MODS - VERSION FIXE
echo ===================================================
echo.
echo Dossier racine: %ROOT_DIR%
echo.
echo Choisissez un mod à compiler:
echo.
echo 1. lootr-tweaker
echo 2. enchantment-disabler
echo 3. Compiler tous les mods
echo 4. Vérifier l'environnement
echo 5. Retour au menu principal
echo.
set /p choice="Votre choix (1-5): "

if "%choice%"=="1" goto compile_lootr
if "%choice%"=="2" goto compile_enchant
if "%choice%"=="3" goto compile_all
if "%choice%"=="4" goto check_env
if "%choice%"=="5" goto exit

echo Choix invalide! Veuillez réessayer.
timeout /t 2 >nul
goto main_menu

:compile_lootr
cls
echo.
echo ===================================================
echo     COMPILATION DE LOOTR-TWEAKER
echo ===================================================
echo.

if not exist "%ROOT_DIR%\lootr-tweaker" (
    echo [ERREUR] Le dossier lootr-tweaker n'existe pas dans %ROOT_DIR%
    echo.
    pause
    goto main_menu
)

cd /d "%ROOT_DIR%\lootr-tweaker"
echo Compilation en cours dans: %CD%
echo.

call gradlew clean build --no-daemon

if %ERRORLEVEL% EQU 0 (
    echo.
    echo [SUCCÈS] La compilation de lootr-tweaker a réussi!
    echo Le fichier JAR se trouve dans %ROOT_DIR%\lootr-tweaker\build\libs\
) else (
    echo.
    echo [ÉCHEC] La compilation de lootr-tweaker a échoué!
)

echo.
pause
goto main_menu

:compile_enchant
cls
echo.
echo ===================================================
echo     COMPILATION DE ENCHANTMENT-DISABLER
echo ===================================================
echo.

if not exist "%ROOT_DIR%\enchantment-disabler" (
    echo [ERREUR] Le dossier enchantment-disabler n'existe pas dans %ROOT_DIR%
    echo.
    pause
    goto main_menu
)

cd /d "%ROOT_DIR%\enchantment-disabler"
echo Compilation en cours dans: %CD%
echo.

call gradlew clean build --no-daemon

if %ERRORLEVEL% EQU 0 (
    echo.
    echo [SUCCÈS] La compilation de enchantment-disabler a réussi!
    echo Le fichier JAR se trouve dans %ROOT_DIR%\enchantment-disabler\build\libs\
) else (
    echo.
    echo [ÉCHEC] La compilation de enchantment-disabler a échoué!
)

echo.
pause
goto main_menu

:compile_all
cls
echo.
echo ===================================================
echo     COMPILATION DE TOUS LES MODS
echo ===================================================
echo.

set SUCCESS_COUNT=0
set FAIL_COUNT=0

echo === Compilation de lootr-tweaker ===
echo.
if exist "%ROOT_DIR%\lootr-tweaker" (
    cd /d "%ROOT_DIR%\lootr-tweaker"
    call gradlew clean build --no-daemon
    
    if %ERRORLEVEL% EQU 0 (
        echo [SUCCÈS] lootr-tweaker a été compilé avec succès!
        set /a SUCCESS_COUNT+=1
    ) else (
        echo [ÉCHEC] La compilation de lootr-tweaker a échoué!
        set /a FAIL_COUNT+=1
    )
) else (
    echo [ERREUR] Le dossier lootr-tweaker n'existe pas!
    set /a FAIL_COUNT+=1
)
echo.

echo === Compilation de enchantment-disabler ===
echo.
if exist "%ROOT_DIR%\enchantment-disabler" (
    cd /d "%ROOT_DIR%\enchantment-disabler"
    call gradlew clean build --no-daemon
    
    if %ERRORLEVEL% EQU 0 (
        echo [SUCCÈS] enchantment-disabler a été compilé avec succès!
        set /a SUCCESS_COUNT+=1
    ) else (
        echo [ÉCHEC] La compilation de enchantment-disabler a échoué!
        set /a FAIL_COUNT+=1
    )
) else (
    echo [ERREUR] Le dossier enchantment-disabler n'existe pas!
    set /a FAIL_COUNT+=1
)
echo.

echo ===================================================
echo              RÉSUMÉ DE COMPILATION
echo ===================================================
echo.
echo Mods compilés avec succès: %SUCCESS_COUNT%
echo Mods dont la compilation a échoué: %FAIL_COUNT%
echo.
pause
goto main_menu

:check_env
cls
echo.
echo ===================================================
echo     VÉRIFICATION DE L'ENVIRONNEMENT
echo ===================================================
echo.

echo Test: Java...
java -version 2>nul
if %ERRORLEVEL% EQU 0 (
    echo [OK] Java est installé et accessible.
) else (
    echo [ERREUR] Java n'est pas accessible! Veuillez installer JDK 17 ou supérieur.
)
echo.

echo Test: Structure du projet...
if exist "%ROOT_DIR%\lootr-tweaker" (
    echo [OK] Le dossier lootr-tweaker existe.
) else (
    echo [ERREUR] Le dossier lootr-tweaker n'existe pas!
)

if exist "%ROOT_DIR%\enchantment-disabler" (
    echo [OK] Le dossier enchantment-disabler existe.
) else (
    echo [ERREUR] Le dossier enchantment-disabler n'existe pas!
)
echo.

echo Test: Fichiers de configuration Gradle...
if exist "%ROOT_DIR%\lootr-tweaker\build.gradle" (
    echo [OK] Le fichier build.gradle existe pour lootr-tweaker.
) else (
    echo [ERREUR] Le fichier build.gradle est manquant pour lootr-tweaker!
)

if exist "%ROOT_DIR%\enchantment-disabler\build.gradle" (
    echo [OK] Le fichier build.gradle existe pour enchantment-disabler.
) else (
    echo [ERREUR] Le fichier build.gradle est manquant pour enchantment-disabler!
)
echo.

echo Test: Gradle Wrapper...
if exist "%ROOT_DIR%\lootr-tweaker\gradlew.bat" (
    echo [OK] Le fichier gradlew.bat existe pour lootr-tweaker.
) else (
    echo [ERREUR] Le fichier gradlew.bat est manquant pour lootr-tweaker!
)

if exist "%ROOT_DIR%\enchantment-disabler\gradlew.bat" (
    echo [OK] Le fichier gradlew.bat existe pour enchantment-disabler.
) else (
    echo [ERREUR] Le fichier gradlew.bat est manquant pour enchantment-disabler!
)
echo.

echo ===================================================
echo       Vérification de l'environnement terminée
echo ===================================================
echo.
pause
goto main_menu

:exit
cd /d "%ROOT_DIR%"
exit /b 0