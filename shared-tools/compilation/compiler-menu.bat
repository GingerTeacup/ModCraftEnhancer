@echo off
setlocal enabledelayedexpansion
title Compilateur Kraphtea-Mods v1.0

:menu
cls
echo ===============================================
echo     COMPILATEUR KRAPHTEA-MODS
echo ===============================================
echo.
echo Cette interface vous aide à compiler vos mods Minecraft
echo et reste ouverte pour voir les résultats.
echo.
echo Dossier actuel: %CD%
echo.
echo Options:
echo 1. Compiler lootr-tweaker
echo 2. Compiler enchantment-disabler
echo 3. Compiler tous les mods
echo 4. Vérifier l'environnement
echo 5. Quitter
echo.
echo ===============================================
set /p choix=Votre choix (1-5): 

if "%choix%"=="1" goto compile_lootr
if "%choix%"=="2" goto compile_enchant
if "%choix%"=="3" goto compile_all
if "%choix%"=="4" goto check_env
if "%choix%"=="5" goto end

echo Choix invalide. Veuillez réessayer.
timeout /t 2 >nul
goto menu

:compile_lootr
cls
echo ===============================================
echo     COMPILATION DE LOOTR-TWEAKER
echo ===============================================
echo.
echo Vérification du dossier...

set MOD_PATH=..\..\lootr-tweaker

if not exist "%MOD_PATH%" (
    echo [ERREUR] Dossier "%MOD_PATH%" introuvable!
    echo Assurez-vous d'exécuter ce script depuis le dossier:
    echo kraphtea-mods\shared-tools\compilation\
    echo.
    pause
    goto menu
)

cd "%MOD_PATH%"
echo Dossier actuel: %CD%
echo.
echo Lancement de la compilation...
echo.

call gradlew clean build -x test

echo.
if %ERRORLEVEL% EQU 0 (
    echo [SUCCÈS] Compilation réussie!
) else (
    echo [ERREUR] Échec de la compilation.
)
echo.
pause
cd ..\..\shared-tools\compilation
goto menu

:compile_enchant
cls
echo ===============================================
echo     COMPILATION DE ENCHANTMENT-DISABLER
echo ===============================================
echo.
echo Vérification du dossier...

set MOD_PATH=..\..\enchantment-disabler

if not exist "%MOD_PATH%" (
    echo [ERREUR] Dossier "%MOD_PATH%" introuvable!
    echo Assurez-vous d'exécuter ce script depuis le dossier:
    echo kraphtea-mods\shared-tools\compilation\
    echo.
    pause
    goto menu
)

cd "%MOD_PATH%"
echo Dossier actuel: %CD%
echo.
echo Lancement de la compilation...
echo.

call gradlew clean build -x test

echo.
if %ERRORLEVEL% EQU 0 (
    echo [SUCCÈS] Compilation réussie!
) else (
    echo [ERREUR] Échec de la compilation.
)
echo.
pause
cd ..\..\shared-tools\compilation
goto menu

:compile_all
cls
echo ===============================================
echo     COMPILATION DE TOUS LES MODS
echo ===============================================
echo.

set MODS=..\..\lootr-tweaker ..\..\enchantment-disabler
set SUCCESS=0
set FAILED=0

for %%m in (%MODS%) do (
    echo Compilation de %%m...
    echo.
    
    if not exist "%%m" (
        echo [ERREUR] Dossier "%%m" introuvable!
        echo.
        set /a FAILED+=1
        continue
    )
    
    cd "%%m"
    echo Dossier actuel: %CD%
    echo.
    
    call gradlew clean build -x test
    
    if %ERRORLEVEL% EQU 0 (
        echo [SUCCÈS] Compilation réussie!
        set /a SUCCESS+=1
    ) else (
        echo [ERREUR] Échec de la compilation.
        set /a FAILED+=1
    )
    echo.
    cd ..\..\shared-tools\compilation
)

echo ===============================================
echo     RÉSUMÉ
echo ===============================================
echo.
echo Mods compilés avec succès: %SUCCESS%
echo Mods ayant échoué: %FAILED%
echo.
pause
goto menu

:check_env
cls
echo ===============================================
echo     VÉRIFICATION DE L'ENVIRONNEMENT
echo ===============================================
echo.

echo Test: Accès à Java...
java -version 2>nul
if %ERRORLEVEL% EQU 0 (
    echo [OK] Java est disponible.
) else (
    echo [ERREUR] Java n'est pas disponible!
    echo Veuillez installer Java Development Kit (JDK).
)
echo.

echo Test: Accès à Gradle...
gradle -version 2>nul
if %ERRORLEVEL% EQU 0 (
    echo [OK] Gradle est disponible globalement.
) else (
    echo [INFO] Gradle global non disponible, mais ce n'est pas un problème.
    echo        Le Gradle Wrapper (gradlew) sera utilisé à la place.
)
echo.

echo Test: Structure des dossiers...
if exist "..\..\lootr-tweaker" (
    echo [OK] Dossier lootr-tweaker trouvé.
) else (
    echo [ERREUR] Dossier lootr-tweaker non trouvé!
)

if exist "..\..\enchantment-disabler" (
    echo [OK] Dossier enchantment-disabler trouvé.
) else (
    echo [ERREUR] Dossier enchantment-disabler non trouvé!
)
echo.

echo Test: Fichiers de build...
if exist "..\..\lootr-tweaker\build.gradle" (
    echo [OK] build.gradle trouvé pour lootr-tweaker.
) else (
    echo [ERREUR] build.gradle non trouvé pour lootr-tweaker!
)

if exist "..\..\enchantment-disabler\build.gradle" (
    echo [OK] build.gradle trouvé pour enchantment-disabler.
) else (
    echo [ERREUR] build.gradle non trouvé pour enchantment-disabler!
)
echo.

echo ===============================================
echo Vérification terminée. Veuillez résoudre les problèmes indiqués.
echo ===============================================
echo.
pause
goto menu

:end
cls
echo ===============================================
echo     FERMETURE DU COMPILATEUR KRAPHTEA-MODS
echo ===============================================
echo.
echo Merci d'avoir utilisé le compilateur Kraphtea-Mods!
echo.
timeout /t 3 >nul
exit /b 0