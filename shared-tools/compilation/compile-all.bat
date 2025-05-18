@echo off
setlocal enabledelayedexpansion

REM ===============================================
REM     Compilateur Global Kraphtea-Mods
REM     Version: 1.0.0
REM ===============================================

echo ===============================================
echo     Compilation de tous les mods Kraphtea
echo ===============================================
echo.

REM Liste des mods à compiler
set MODS=lootr-tweaker enchantment-disabler

REM Statistiques
set TOTAL_MODS=0
set SUCCESSFUL_MODS=0
set FAILED_MODS=0
set SKIPPED_MODS=0

REM Calcul du nombre total de mods
for %%m in (%MODS%) do (
    set /a TOTAL_MODS+=1
)

echo [INFO] %TOTAL_MODS% mods trouvés à compiler
echo.

REM Paramètres de mémoire pour Gradle
set GRADLE_OPTS=-Xmx512m -XX:MaxMetaspaceSize=256m -Dorg.gradle.jvmargs=-Xmx512m

REM Boucle sur chaque mod
for %%m in (%MODS%) do (
    set MOD_NAME=%%m
    
    echo [%SUCCESSFUL_MODS%/%FAILED_MODS%/%TOTAL_MODS%] Compilation de !MOD_NAME!...
    
    if not exist "!MOD_NAME!" (
        echo [ERREUR] Le dossier du mod !MOD_NAME! n'existe pas
        set /a SKIPPED_MODS+=1
        echo.
        continue
    )
    
    if not exist "!MOD_NAME!\build.gradle" (
        echo [ERREUR] build.gradle introuvable pour !MOD_NAME!
        set /a SKIPPED_MODS+=1
        echo.
        continue
    )
    
    cd !MOD_NAME!
    
    echo [INFO] Nettoyage des fichiers existants...
    if exist "build\libs\*.jar" del /q "build\libs\*.jar"
    
    echo [INFO] Démarrage de la compilation avec mémoire optimisée...
    
    REM Premier essai avec paramètres optimisés
    call gradlew --no-daemon clean build -x test
    
    if %ERRORLEVEL% NEQ 0 (
        echo [AVERT] Échec de la compilation avec paramètres optimisés
        echo [AVERT] Tentative avec plus de mémoire...
        
        set GRADLE_OPTS=-Xmx768m -XX:MaxMetaspaceSize=384m -Dorg.gradle.jvmargs=-Xmx768m
        call gradlew --no-daemon clean build -x test
        
        if %ERRORLEVEL% NEQ 0 (
            echo [ERREUR] Échec de la compilation de !MOD_NAME!
            set /a FAILED_MODS+=1
        ) else (
            echo [SUCCÈS] !MOD_NAME! compilé avec paramètres de mémoire augmentés
            set /a SUCCESSFUL_MODS+=1
        )
    ) else (
        echo [SUCCÈS] !MOD_NAME! compilé avec succès
        set /a SUCCESSFUL_MODS+=1
    )
    
    cd ..
    echo.
)

echo ===============================================
echo     RÉSUMÉ DE COMPILATION
echo ===============================================
echo.
echo Total des mods:    %TOTAL_MODS%
echo Compilés:          %SUCCESSFUL_MODS%
echo Échoués:           %FAILED_MODS%
echo Ignorés:           %SKIPPED_MODS%
echo.

if %FAILED_MODS% EQU 0 (
    echo Tous les mods ont été compilés avec succès!
) else (
    echo ATTENTION: %FAILED_MODS% mod(s) n'ont pas pu être compilés.
    echo Vérifiez les journaux ci-dessus pour plus de détails.
)

echo.
echo ===============================================
echo.
echo Pour installer les mods:
echo 1. Copiez les fichiers JAR depuis les dossiers build\libs de chaque mod
echo 2. Placez-les dans votre dossier 'mods' de Minecraft
echo.
echo Merci d'utiliser le compilateur Kraphtea-Mods!

exit /b 0