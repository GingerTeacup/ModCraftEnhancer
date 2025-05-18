@echo off
setlocal enabledelayedexpansion

echo ===============================================
echo     RÉPARATION DES FICHIERS GRADLE
echo ===============================================
echo.
echo Ce script va créer les fichiers gradlew manquants
echo nécessaires à la compilation des mods.
echo.

set MODS=..\lootr-tweaker ..\enchantment-disabler

for %%m in (%MODS%) do (
    echo Vérification du mod: %%m
    
    if not exist "%%m" (
        echo [ERREUR] Le dossier %%m n'existe pas!
        echo.
        continue
    )
    
    cd "%%m"
    echo Dossier actuel: %CD%
    
    if not exist "gradlew" (
        echo [INFO] Fichier gradlew manquant, création en cours...
        
        echo @echo off > gradlew.bat
        echo. >> gradlew.bat
        echo @rem Cette commande peut nécessiter l'installation de Gradle >> gradlew.bat
        echo @rem Si Gradle n'est pas installé, veuillez le télécharger depuis https://gradle.org/install/ >> gradlew.bat
        echo. >> gradlew.bat
        echo @rem Si vous avez Gradle installé mais pas dans le PATH, modifiez cette ligne pour pointer vers votre installation >> gradlew.bat
        echo gradle %%* >> gradlew.bat
        
        echo #!/bin/sh > gradlew
        echo # Cette commande peut nécessiter l'installation de Gradle >> gradlew
        echo # Si Gradle n'est pas installé, veuillez le télécharger depuis https://gradle.org/install/ >> gradlew
        echo gradle "$@" >> gradlew
        
        echo [SUCCÈS] Fichiers gradlew créés!
    ) else (
        echo [OK] Le fichier gradlew existe déjà.
    )
    
    if not exist "gradle" (
        echo [INFO] Dossier gradle manquant, création en cours...
        mkdir gradle\wrapper
        
        echo distributionBase=GRADLE_USER_HOME > gradle\wrapper\gradle-wrapper.properties
        echo distributionPath=wrapper/dists >> gradle\wrapper\gradle-wrapper.properties
        echo distributionUrl=https\://services.gradle.org/distributions/gradle-8.1.1-bin.zip >> gradle\wrapper\gradle-wrapper.properties
        echo zipStoreBase=GRADLE_USER_HOME >> gradle\wrapper\gradle-wrapper.properties
        echo zipStorePath=wrapper/dists >> gradle\wrapper\gradle-wrapper.properties
        
        echo [SUCCÈS] Fichiers de configuration gradle créés!
    ) else (
        echo [OK] Le dossier gradle existe déjà.
    )
    
    echo.
    cd "..\..\shared-tools"
)

echo ===============================================
echo     INSTALLATION DE GRADLE (FACULTATIF)
echo ===============================================
echo.
echo Pour que la compilation fonctionne, vous devez avoir Gradle installé.
echo.
echo Options d'installation:
echo 1. Télécharger et installer Gradle à partir de https://gradle.org/install/
echo 2. Installer via un gestionnaire de paquets comme Chocolatey:
echo    choco install gradle
echo.
echo Après l'installation, assurez-vous que Gradle est dans votre PATH système.
echo.

echo ===============================================
echo     VÉRIFICATION DE JAVA
echo ===============================================
echo.
echo Pour que Gradle fonctionne, Java JDK doit être installé.
echo.
echo Vérification de Java...
java -version 2>nul

if %ERRORLEVEL% EQU 0 (
    echo [OK] Java est installé sur votre système.
) else (
    echo [ERREUR] Java n'est pas détecté!
    echo Veuillez installer Java JDK 17 ou supérieur depuis:
    echo https://adoptium.net/
)

echo.
echo ===============================================
echo Réparation terminée! Vous pouvez maintenant essayer à nouveau
echo le script de compilation.
echo ===============================================
echo.
pause