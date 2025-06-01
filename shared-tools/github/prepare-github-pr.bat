@echo off
setlocal enabledelayedexpansion

REM ===============================================
REM     Préparation pour Pull Request GitHub
REM ===============================================

REM Vérifie si un nom de mod a été fourni
if "%~1"=="" (
    echo Erreur: Veuillez spécifier le nom du mod
    echo Exemple: prepare-github-pr.bat lootr-tweaker
    exit /b 1
)

REM Récupère le nom du mod et le chemin
set "MOD_NAME=%~1"
set "MOD_PATH=..\..\%MOD_NAME%"

if not exist "%MOD_PATH%" (
    echo Erreur: Le dossier du mod n'existe pas: %MOD_PATH%
    exit /b 1
)

REM Vérifie si un message de PR a été fourni
if "%~2"=="" (
    echo Erreur: Veuillez spécifier un message de PR
    echo Exemple: prepare-github-pr.bat lootr-tweaker "Ajout de fonctionnalité X"
    exit /b 1
)

set "PR_MESSAGE=%~2"
set "EXPORT_DIR=..\..\%MOD_NAME%_pr_export"

echo ===============================================
echo     Préparation pour Pull Request: %MOD_NAME%
echo     Message: %PR_MESSAGE%
echo ===============================================
echo.

echo [1/4] Création du dossier d'export...
if exist "%EXPORT_DIR%" rd /s /q "%EXPORT_DIR%"
mkdir "%EXPORT_DIR%"

echo [2/4] Copie des fichiers...
xcopy /E /I /Y "%MOD_PATH%\*" "%EXPORT_DIR%\" > nul

echo [3/4] Nettoyage des fichiers temporaires...
if exist "%EXPORT_DIR%\.gradle" rd /s /q "%EXPORT_DIR%\.gradle"
if exist "%EXPORT_DIR%\build" rd /s /q "%EXPORT_DIR%\build"
if exist "%EXPORT_DIR%\*.log" del /q "%EXPORT_DIR%\*.log"
if exist "%EXPORT_DIR%\*.hprof" del /q "%EXPORT_DIR%\*.hprof"

echo [4/4] Création du fichier README pour la PR...
echo # Pull Request: %PR_MESSAGE% > "%EXPORT_DIR%\PR_README.md"
echo. >> "%EXPORT_DIR%\PR_README.md"
echo ## Mod concerné >> "%EXPORT_DIR%\PR_README.md"
echo. >> "%EXPORT_DIR%\PR_README.md"
echo %MOD_NAME% >> "%EXPORT_DIR%\PR_README.md"
echo. >> "%EXPORT_DIR%\PR_README.md"
echo ## Changements effectués >> "%EXPORT_DIR%\PR_README.md"
echo. >> "%EXPORT_DIR%\PR_README.md"
echo - [Listez ici les changements détaillés] >> "%EXPORT_DIR%\PR_README.md"
echo. >> "%EXPORT_DIR%\PR_README.md"
echo ## Comment tester >> "%EXPORT_DIR%\PR_README.md"
echo. >> "%EXPORT_DIR%\PR_README.md"
echo 1. Compilez le mod avec le script compile.bat >> "%EXPORT_DIR%\PR_README.md"
echo 2. Installez le mod dans votre dossier mods de Minecraft >> "%EXPORT_DIR%\PR_README.md"
echo 3. [Instructions spécifiques au test] >> "%EXPORT_DIR%\PR_README.md"

echo ===============================================
echo       PRÉPARATION TERMINÉE!
echo ===============================================
echo.
echo Les fichiers pour la PR ont été préparés dans le dossier:
echo %EXPORT_DIR%
echo.
echo Instructions pour soumettre la PR:
echo 1. Créez une branche dans votre fork GitHub
echo 2. Téléchargez les fichiers du dossier d'export
echo 3. Mettez à jour les fichiers dans votre branche
echo 4. Créez une PR avec le message: %PR_MESSAGE%
echo 5. Copiez le contenu de PR_README.md dans la description de la PR
echo.
echo Vous pouvez aussi utiliser ce dossier comme base pour
echo créer un patch ou un diff avec les fichiers originaux.

exit /b 0