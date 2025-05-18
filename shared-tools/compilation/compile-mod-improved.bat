@echo off
setlocal enabledelayedexpansion

REM ===============================================
REM     Compilateur Kraphtea-Mods Amélioré
REM     Version: 1.1.0
REM ===============================================

REM Configuration pour afficher la fenêtre plus longtemps
title Compilation de Mod Kraphtea

REM Récupère le chemin du mod
if "%~1"=="" (
    set "MOD_PATH=."
) else (
    set "MOD_PATH=%~1"
)

echo ===============================================
echo     Vérification initiale
echo ===============================================

REM Vérification des fichiers Gradle avec plus de détails
echo Vérification des fichiers requis...
if not exist "%MOD_PATH%\build.gradle" (
    echo [ERREUR] build.gradle introuvable dans %MOD_PATH%
    echo          Chemin complet: %CD%\%MOD_PATH%\build.gradle
    echo          Vérifiez que vous exécutez ce script depuis le bon dossier
    goto error_exit
)

if not exist "%MOD_PATH%\gradlew" (
    echo [ERREUR] gradlew introuvable dans %MOD_PATH%
    echo          Chemin complet: %CD%\%MOD_PATH%\gradlew
    echo          Vérifiez que vous exécutez ce script depuis le bon dossier
    goto error_exit
)

REM Recueille des informations sur le mod
echo Analyse du mod...
set MOD_NAME=Mod inconnu
set MOD_VERSION=0.0.0

REM Tente de lire le nom du mod depuis le README.md
if exist "%MOD_PATH%\README.md" (
    for /f "tokens=1,* delims=# " %%a in ('type "%MOD_PATH%\README.md" ^| findstr /B "#"') do (
        set "MOD_NAME=%%b"
        goto :found_name
    )
)
:found_name

REM Tente de lire la version depuis gradle.properties
if exist "%MOD_PATH%\gradle.properties" (
    for /f "tokens=1,2 delims==" %%a in ('type "%MOD_PATH%\gradle.properties" ^| findstr "mod_version"') do (
        set "MOD_VERSION=%%b"
        goto :found_version
    )
)
:found_version

echo ===============================================
echo     Compilation de %MOD_NAME% v%MOD_VERSION%
echo     Dossier: %MOD_PATH%
echo ===============================================
echo.

REM Paramètres de mémoire optimisés
set GRADLE_OPTS=-Xmx256m -XX:MaxMetaspaceSize=96m -Dorg.gradle.jvmargs=-Xmx256m

echo [1/4] Nettoyage des fichiers temporaires...
if exist "%MOD_PATH%\build\libs\*.jar" del /q "%MOD_PATH%\build\libs\*.jar"

echo [2/4] Configuration de Gradle...
cd "%MOD_PATH%" || (
    echo [ERREUR] Impossible d'accéder au dossier %MOD_PATH%
    goto error_exit
)

echo [INFO] Dossier actuel: %CD%

if not exist gradlew (
    echo [ERREUR] Script gradlew introuvable dans le dossier actuel!
    echo          Chemin attendu: %CD%\gradlew
    goto error_exit
)

echo [3/4] Compilation du mod...
echo Lancement avec mémoire optimisée (256Mo)...
call gradlew --no-daemon clean build -x test

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [!] Échec de la compilation avec les paramètres optimisés
    echo [!] Tentative avec des paramètres de mémoire plus élevés...
    echo.
    
    set GRADLE_OPTS=-Xmx512m -XX:MaxMetaspaceSize=128m -Dorg.gradle.jvmargs=-Xmx512m
    call gradlew --no-daemon clean build -x test
    
    if %ERRORLEVEL% NEQ 0 (
        echo.
        echo [!!] Échec de la compilation avec les paramètres intermédiaires
        echo [!!] Dernière tentative avec mémoire maximale...
        echo.
        
        set GRADLE_OPTS=-Xmx768m -XX:MaxMetaspaceSize=256m -Dorg.gradle.jvmargs=-Xmx768m
        call gradlew --no-daemon clean build -x test
        
        if %ERRORLEVEL% NEQ 0 (
            echo.
            echo [!!!] ERREUR: La compilation a échoué même avec les paramètres de mémoire maximale
            echo.
            echo Veuillez vérifier les erreurs ci-dessus ou exécuter manuellement:
            echo   gradlew clean build --debug
            echo.
            goto error_exit
        )
    )
)

echo [4/4] Vérification du fichier JAR...
if not exist "build\libs\*.jar" (
    echo.
    echo [!] ERREUR: Le fichier JAR n'a pas été généré!
    echo.
    goto error_exit
)

echo.
echo ===============================================
echo     COMPILATION RÉUSSIE!
echo ===============================================
echo.
echo Fichiers JAR générés:
for %%F in ("build\libs\*.jar") do (
    echo - %%~nxF (%%~zF octets)
)
echo.
echo Vous pouvez trouver les fichiers JAR dans:
echo %CD%\build\libs\
echo.
echo Installation:
echo 1. Copiez le fichier JAR dans votre dossier 'mods' de Minecraft
echo 2. Lancez le jeu
echo.
echo Merci d'utiliser le compilateur Kraphtea-Mods!

goto normal_exit

:error_exit
echo.
echo ===============================================
echo     ERREUR DE COMPILATION
echo ===============================================
echo.
echo Le processus de compilation a échoué.
echo Vérifiez les messages d'erreur ci-dessus pour plus de détails.
echo.
echo Conseil de dépannage:
echo - Vérifiez que vous exécutez ce script depuis le dossier racine du projet
echo - Assurez-vous que Java est correctement installé et configuré
echo - Vérifiez la connexion Internet pour le téléchargement des dépendances
echo.
echo Dossier actuel: %CD%
echo.

:normal_exit
echo.
echo ===============================================
echo     Fin du processus
echo ===============================================
echo.
echo Appuyez sur une touche pour fermer cette fenêtre...
pause > nul
exit /b 0