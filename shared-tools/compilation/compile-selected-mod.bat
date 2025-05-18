@echo off
setlocal enabledelayedexpansion

title Sélecteur de Compilation de Mod Kraphtea

echo ===============================================
echo     COMPILATEUR DE MOD SÉLECTIF
echo ===============================================
echo.
echo Ce script détecte automatiquement les mods disponibles
echo et vous permet de choisir lequel compiler.
echo.

REM Détermination du dossier racine
cd ..\..
set ROOT_DIR=%CD%
echo Dossier racine du projet: %ROOT_DIR%
echo.

REM Recherche des mods dans le dossier racine
echo Recherche des mods disponibles...
echo.

set MOD_COUNT=0
set MOD_LIST=

REM Exploration du dossier pour trouver des dossiers qui semblent être des mods
for /d %%d in (*) do (
    REM Vérification s'il s'agit d'un dossier de mod (contient build.gradle ou est nommé comme un mod connu)
    if exist "%%d\build.gradle" (
        set /a MOD_COUNT+=1
        set "MOD_LIST=!MOD_LIST!!MOD_COUNT!. %%d!NL!"
        set "MOD_!MOD_COUNT!=%%d"
    ) else (
        REM Vérification par nom (pour les cas où build.gradle peut manquer)
        set MOD_NAME=%%d
        if "!MOD_NAME!"=="lootr-tweaker" (
            set /a MOD_COUNT+=1
            set "MOD_LIST=!MOD_LIST!!MOD_COUNT!. %%d!NL!"
            set "MOD_!MOD_COUNT!=%%d"
        ) else if "!MOD_NAME!"=="enchantment-disabler" (
            set /a MOD_COUNT+=1
            set "MOD_LIST=!MOD_LIST!!MOD_COUNT!. %%d!NL!"
            set "MOD_!MOD_COUNT!=%%d"
        )
    )
)

if %MOD_COUNT% EQU 0 (
    echo [ERREUR] Aucun mod n'a été trouvé dans le dossier %ROOT_DIR%.
    echo Assurez-vous d'avoir téléchargé ou créé les mods correctement.
    echo.
    goto error_exit
)

echo %MOD_COUNT% mods trouvés:
echo ---------------
set NL=^


REM Ligne vide ci-dessus est intentionnelle pour définir une nouvelle ligne
for /L %%i in (1,1,%MOD_COUNT%) do (
    echo %%i. !MOD_%%i!
)
echo ---------------
echo.

:ask_mod
set /p MOD_CHOICE=Choisissez le numéro du mod à compiler (1-%MOD_COUNT%): 

REM Validation du choix
if "%MOD_CHOICE%"=="" goto ask_mod
set /a MOD_CHOICE_NUM=%MOD_CHOICE% 2>nul
if %MOD_CHOICE_NUM% LSS 1 (
    echo Choix invalide. Veuillez entrer un nombre entre 1 et %MOD_COUNT%.
    goto ask_mod
)
if %MOD_CHOICE_NUM% GTR %MOD_COUNT% (
    echo Choix invalide. Veuillez entrer un nombre entre 1 et %MOD_COUNT%.
    goto ask_mod
)

set SELECTED_MOD=!MOD_%MOD_CHOICE_NUM%!
echo.
echo Vous avez choisi de compiler: %SELECTED_MOD%
echo.
echo ===============================================
echo     COMPILATION DE %SELECTED_MOD%
echo ===============================================
echo.

REM Vérification des fichiers requis
if not exist "%SELECTED_MOD%\build.gradle" (
    echo [AVERTISSEMENT] Le fichier build.gradle est manquant dans %SELECTED_MOD%.
    echo Ce fichier est nécessaire pour la compilation. Voulez-vous continuer quand même?
    echo.
    set /p CONTINUE=Continuer? (o/n): 
    if /i not "%CONTINUE%"=="o" goto error_exit
)

REM Exécution de la compilation
cd %SELECTED_MOD%
echo Dossier actuel: %CD%
echo.

REM Configuration de Gradle
set GRADLE_OPTS=-Xmx512m -XX:MaxMetaspaceSize=256m -Dorg.gradle.jvmargs=-Xmx512m

echo [1/3] Vérification de l'environnement Java...
java -version 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERREUR] Java n'est pas détecté dans le PATH système.
    echo Veuillez installer Java JDK et vous assurer qu'il est dans votre PATH.
    goto error_exit
)

echo [2/3] Nettoyage des fichiers précédents...
if exist "build\libs\*.jar" del /q "build\libs\*.jar"

echo [3/3] Lancement de la compilation...
echo.

REM Vérification de l'existence de gradlew ou gradle
if exist "gradlew.bat" (
    echo Utilisation du wrapper Gradle local (gradlew)...
    call gradlew clean build -x test
) else (
    echo Recherche de Gradle dans le PATH système...
    gradle -version >nul 2>&1
    
    if %ERRORLEVEL% EQU 0 (
        echo Utilisation de Gradle système...
        gradle clean build -x test
    ) else (
        echo [ERREUR] Ni gradlew ni Gradle n'ont été trouvés.
        echo.
        echo Solutions possibles:
        echo 1. Exécutez d'abord le script fix-gradlew.bat pour créer les fichiers nécessaires
        echo 2. Installez Gradle et ajoutez-le à votre PATH système
        echo.
        goto error_exit
    )
)

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERREUR] La compilation a échoué avec l'erreur %ERRORLEVEL%.
    echo Vérifiez les messages d'erreur ci-dessus pour plus de détails.
    goto error_exit
)

echo.
echo ===============================================
echo     COMPILATION RÉUSSIE
echo ===============================================
echo.

if exist "build\libs\*.jar" (
    echo Fichiers JAR générés:
    for %%F in ("build\libs\*.jar") do (
        echo - %%~nxF (%%~zF octets)
    )
    echo.
    echo Vous pouvez trouver les fichiers JAR dans:
    echo %CD%\build\libs\
) else (
    echo [AVERTISSEMENT] Aucun fichier JAR n'a été généré dans build\libs\
    echo Vérifiez les messages ci-dessus pour comprendre pourquoi.
)

echo.
echo ===============================================
echo     FIN DE LA COMPILATION
echo ===============================================
echo.
goto exit

:error_exit
echo.
echo ===============================================
echo     ERREUR DE COMPILATION
echo ===============================================
echo.
echo La compilation n'a pas pu être terminée en raison d'erreurs.
echo Vérifiez les messages d'erreur ci-dessus.
echo.

:exit
echo Appuyez sur une touche pour fermer cette fenêtre...
pause > nul