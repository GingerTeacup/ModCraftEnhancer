@echo off
setlocal enabledelayedexpansion

REM ===============================================
REM     Outil d'analyse des mods Kraphtea
REM     Version: 1.0.0
REM ===============================================

echo ===============================================
echo     Analyse des mods Kraphtea
echo ===============================================
echo.

REM Liste des mods à analyser
set MODS=lootr-tweaker enchantment-disabler

REM Vérification des paramètres
if "%~1"=="" (
    echo Utilisation: analyze-mods.bat [option]
    echo Options disponibles:
    echo   jar-size    - Analyse la taille des fichiers JAR
    echo   structure   - Vérifie la structure des dossiers des mods
    echo   deps        - Analyse les dépendances
    echo   full        - Exécute toutes les analyses
    echo.
    goto :EOF
)

set OPTION=%~1

REM Exécution de l'analyse demandée
if "%OPTION%"=="jar-size" (
    call :analyzeJarSize
) else if "%OPTION%"=="structure" (
    call :analyzeStructure
) else if "%OPTION%"=="deps" (
    call :analyzeDependencies
) else if "%OPTION%"=="full" (
    call :analyzeJarSize
    call :analyzeStructure
    call :analyzeDependencies
) else (
    echo Option inconnue: %OPTION%
    echo Utilisez 'jar-size', 'structure', 'deps' ou 'full'
    goto :EOF
)

goto :EOF

REM === Fonction: Analyser la taille des JAR ===
:analyzeJarSize
echo -----------------------------------------
echo Analyse de la taille des fichiers JAR
echo -----------------------------------------
echo.

for %%m in (%MODS%) do (
    set MOD_NAME=%%m
    echo Analyse de !MOD_NAME!:
    
    if not exist "!MOD_NAME!" (
        echo [ERREUR] Le dossier du mod !MOD_NAME! n'existe pas
        echo.
        continue
    )
    
    if not exist "!MOD_NAME!\build\libs\*.jar" (
        echo [AVERT] Aucun fichier JAR trouvé pour !MOD_NAME!
        echo         Veuillez compiler le mod d'abord avec compile-all.bat
        echo.
        continue
    )
    
    for %%j in ("!MOD_NAME!\build\libs\*.jar") do (
        set JAR_SIZE=%%~zj
        set JAR_NAME=%%~nxj
        
        echo Fichier: !JAR_NAME!
        echo Taille:  !JAR_SIZE! octets
        
        if !JAR_SIZE! GTR 1048576 (
            set /a SIZE_MB=!JAR_SIZE! / 1048576
            echo [AVERT] Ce fichier JAR est relativement grand (^>1MB: !SIZE_MB!MB)
            echo         Considérez l'optimisation ou l'utilisation de Git LFS pour ce fichier
        ) else (
            echo [INFO]  Taille acceptable
        )
    )
    echo.
)
exit /b 0

REM === Fonction: Analyser la structure des mods ===
:analyzeStructure
echo -----------------------------------------
echo Analyse de la structure des mods
echo -----------------------------------------
echo.

for %%m in (%MODS%) do (
    set MOD_NAME=%%m
    echo Analyse de !MOD_NAME!:
    
    if not exist "!MOD_NAME!" (
        echo [ERREUR] Le dossier du mod !MOD_NAME! n'existe pas
        echo.
        continue
    )
    
    set STRUCTURE_SCORE=0
    set MAX_SCORE=5
    
    REM Vérifier les éléments structurels
    if exist "!MOD_NAME!\build.gradle" (
        set /a STRUCTURE_SCORE+=1
        echo [OK] build.gradle trouvé
    ) else (
        echo [MANQUANT] build.gradle non trouvé
    )
    
    if exist "!MOD_NAME!\gradle.properties" (
        set /a STRUCTURE_SCORE+=1
        echo [OK] gradle.properties trouvé
    ) else (
        echo [MANQUANT] gradle.properties non trouvé
    )
    
    if exist "!MOD_NAME!\src\main\resources\fabric.mod.json" (
        set /a STRUCTURE_SCORE+=1
        echo [OK] fabric.mod.json trouvé
    ) else (
        echo [MANQUANT] fabric.mod.json non trouvé
    )
    
    if exist "!MOD_NAME!\src\main\java\com\kraphtea" (
        set /a STRUCTURE_SCORE+=1
        echo [OK] Structure de package com.kraphtea trouvée
    ) else (
        echo [MANQUANT] Structure de package com.kraphtea non trouvée
    )
    
    if exist "!MOD_NAME!\src\main\resources\assets" (
        set /a STRUCTURE_SCORE+=1
        echo [OK] Dossier assets trouvé
    ) else (
        echo [MANQUANT] Dossier assets non trouvé
    )
    
    echo Score de structure: !STRUCTURE_SCORE!/!MAX_SCORE!
    
    if !STRUCTURE_SCORE! LSS 3 (
        echo [AVERT] Structure incomplète: score inférieur à 3/5
    ) else if !STRUCTURE_SCORE! EQU !MAX_SCORE! (
        echo [EXCELLENT] Structure parfaite
    ) else (
        echo [BON] Structure acceptable
    )
    echo.
)
exit /b 0

REM === Fonction: Analyser les dépendances ===
:analyzeDependencies
echo -----------------------------------------
echo Analyse des dépendances
echo -----------------------------------------
echo.

for %%m in (%MODS%) do (
    set MOD_NAME=%%m
    echo Analyse de !MOD_NAME!:
    
    if not exist "!MOD_NAME!" (
        echo [ERREUR] Le dossier du mod !MOD_NAME! n'existe pas
        echo.
        continue
    )
    
    if not exist "!MOD_NAME!\src\main\resources\fabric.mod.json" (
        echo [ERREUR] fabric.mod.json non trouvé pour !MOD_NAME!
        echo.
        continue
    )
    
    echo Dépendances déclarées dans fabric.mod.json:
    findstr /C:"depends" "!MOD_NAME!\src\main\resources\fabric.mod.json"
    
    if exist "!MOD_NAME!\build.gradle" (
        echo.
        echo Dépendances déclarées dans build.gradle:
        findstr /C:"modImplementation" "!MOD_NAME!\build.gradle"
    )
    echo.
)
exit /b 0