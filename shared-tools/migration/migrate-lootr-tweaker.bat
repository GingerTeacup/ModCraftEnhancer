@echo off
setlocal enabledelayedexpansion

REM ===============================================
REM     Migration de LootrTweaker vers la nouvelle structure
REM ===============================================

echo Vérification des chemins...
set "SOURCE_PATH=..\..\fabric_mods\lootr_tweaker"
set "TARGET_PATH=..\..\lootr-tweaker"

if not exist "%SOURCE_PATH%" (
    echo Erreur: Le dossier source n'existe pas: %SOURCE_PATH%
    exit /b 1
)

if exist "%TARGET_PATH%" (
    echo Le dossier cible existe déjà: %TARGET_PATH%
    echo Voulez-vous le supprimer et le recréer? (O/N)
    set /p CONFIRM=
    if /i "!CONFIRM!"=="O" (
        rd /s /q "%TARGET_PATH%"
    ) else (
        echo Migration annulée
        exit /b 0
    )
)

echo ===============================================
echo     Migration de LootrTweaker
echo ===============================================
echo.

echo [1/5] Création de la structure de destination...
mkdir "%TARGET_PATH%"
mkdir "%TARGET_PATH%\src"
mkdir "%TARGET_PATH%\src\main"
mkdir "%TARGET_PATH%\src\main\java"
mkdir "%TARGET_PATH%\src\main\resources"

echo [2/5] Copie des fichiers de configuration Gradle...
copy /Y "%SOURCE_PATH%\build.gradle" "%TARGET_PATH%\" > nul
copy /Y "%SOURCE_PATH%\gradle.properties" "%TARGET_PATH%\" > nul
copy /Y "%SOURCE_PATH%\settings.gradle" "%TARGET_PATH%\" > nul

echo [3/5] Copie du code source...
xcopy /E /I /Y "%SOURCE_PATH%\src" "%TARGET_PATH%\src\" > nul

echo [4/5] Copie des fichiers Gradle wrapper...
mkdir "%TARGET_PATH%\gradle\wrapper"
copy /Y "%SOURCE_PATH%\gradle\wrapper\gradle-wrapper.jar" "%TARGET_PATH%\gradle\wrapper\" > nul
copy /Y "%SOURCE_PATH%\gradle\wrapper\gradle-wrapper.properties" "%TARGET_PATH%\gradle\wrapper\" > nul
copy /Y "%SOURCE_PATH%\gradlew" "%TARGET_PATH%\" > nul
copy /Y "%SOURCE_PATH%\gradlew.bat" "%TARGET_PATH%\" > nul

echo [5/5] Copie des fichiers de documentation...
copy /Y "%SOURCE_PATH%\README.md" "%TARGET_PATH%\" > nul
if exist "%SOURCE_PATH%\CHANGELOG.md" copy /Y "%SOURCE_PATH%\CHANGELOG.md" "%TARGET_PATH%\" > nul
if exist "%SOURCE_PATH%\COMPILATION.md" copy /Y "%SOURCE_PATH%\COMPILATION.md" "%TARGET_PATH%\" > nul
if exist "%SOURCE_PATH%\CONFIG.md" copy /Y "%SOURCE_PATH%\CONFIG.md" "%TARGET_PATH%\" > nul
if exist "%SOURCE_PATH%\LICENSE" copy /Y "%SOURCE_PATH%\LICENSE" "%TARGET_PATH%\" > nul

echo Création du script de compilation...
echo @echo off > "%TARGET_PATH%\compile.bat"
echo. >> "%TARGET_PATH%\compile.bat"
echo REM Exécution du compilateur commun >> "%TARGET_PATH%\compile.bat"
echo call ..\shared-tools\compilation\compile-mod.bat . >> "%TARGET_PATH%\compile.bat"

echo ===============================================
echo       MIGRATION RÉUSSIE!
echo ===============================================
echo.
echo Le mod LootrTweaker a été migré avec succès vers la nouvelle structure!
echo.
echo === Prochaines étapes ===
echo 1. Vérifiez que tous les fichiers ont été correctement copiés
echo 2. Testez la compilation avec le script compile.bat
echo 3. Adaptez les imports si nécessaire
echo.
echo Note: La version d'origine est toujours disponible dans %SOURCE_PATH%
echo       Vous pouvez la supprimer une fois que vous avez vérifié que tout fonctionne.

exit /b 0