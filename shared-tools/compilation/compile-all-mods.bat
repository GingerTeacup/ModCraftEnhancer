@echo off
setlocal enabledelayedexpansion

REM =================================================
REM Script de compilation de tous les mods Kraphtea
REM Version 2.0
REM =================================================

echo.
echo ===================================================
echo     COMPILATEUR MULTI-MODS KRAPHTEA - VERSION 2.0
echo ===================================================
echo.

set BASE_DIR=%~dp0..\..\
cd %BASE_DIR%

REM Détection automatique des mods disponibles
echo Détection des mods disponibles...
echo.

set MOD_COUNT=0
set MOD_LIST=

for /d %%D in (*) do (
    if exist "%%D\build.gradle" (
        set /a MOD_COUNT+=1
        set "MOD_!MOD_COUNT!=%%D"
        set "MOD_LIST=!MOD_LIST!   !MOD_COUNT!. %%D!LF!"
    )
)

if %MOD_COUNT% EQU 0 (
    echo [ERREUR] Aucun mod avec build.gradle n'a été trouvé dans ce répertoire.
    goto :EOF
)

echo Les mods suivants seront compilés :
echo.
for /L %%i in (1,1,%MOD_COUNT%) do (
    echo    %%i. !MOD_%%i!
)
echo.

:BUILD_OPTIONS
echo Options de compilation pour tous les mods :
echo    1. Nettoyer et compiler tous les mods (clean build)
echo    2. Compiler uniquement tous les mods (build)
echo    3. Nettoyer uniquement tous les mods (clean)
echo    4. Annuler et quitter
echo.
set /p BUILD_CHOICE="Sélectionnez une option (1-4) : "
echo.

if "%BUILD_CHOICE%"=="4" goto :EOF

set SUCCESS_COUNT=0
set FAILED_COUNT=0
set FAILED_MODS=

for /L %%i in (1,1,%MOD_COUNT%) do (
    set CURRENT_MOD=!MOD_%%i!
    
    echo.
    echo ===== TRAITEMENT DE !CURRENT_MOD! (!%%i!/%MOD_COUNT%) =====
    echo.
    
    cd !CURRENT_MOD!
    
    if "%BUILD_CHOICE%"=="1" (
        echo Nettoyage et compilation de !CURRENT_MOD!...
        call gradlew.bat clean build --no-daemon
    ) else if "%BUILD_CHOICE%"=="2" (
        echo Compilation de !CURRENT_MOD!...
        call gradlew.bat build --no-daemon
    ) else if "%BUILD_CHOICE%"=="3" (
        echo Nettoyage de !CURRENT_MOD!...
        call gradlew.bat clean --no-daemon
    ) else (
        echo [ERREUR] Option invalide
        cd %BASE_DIR%
        goto BUILD_OPTIONS
    )
    
    set BUILD_STATUS=!ERRORLEVEL!
    cd %BASE_DIR%
    
    if !BUILD_STATUS! EQU 0 (
        echo [SUCCÈS] !CURRENT_MOD! traité avec succès.
        set /a SUCCESS_COUNT+=1
    ) else (
        echo [ÉCHEC] Erreur lors du traitement de !CURRENT_MOD! (code !BUILD_STATUS!)
        set /a FAILED_COUNT+=1
        set FAILED_MODS=!FAILED_MODS!    - !CURRENT_MOD!!LF!
    )
)

echo.
echo ===================================================
echo                 RAPPORT DE COMPILATION
echo ===================================================
echo.
echo Total des mods traités : %MOD_COUNT%
echo Mods réussis : %SUCCESS_COUNT%
echo Mods échoués : %FAILED_COUNT%

if %FAILED_COUNT% GTR 0 (
    echo.
    echo Les mods suivants ont échoué :
    echo !FAILED_MODS!
)

echo.
echo Opération terminée.
pause