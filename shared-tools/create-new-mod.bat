@echo off
setlocal enabledelayedexpansion

REM ===============================================
REM     Kraphtea Mods - Créateur de nouveau mod
REM ===============================================

REM Vérifie si un nom de mod a été fourni
if "%~1"=="" (
    echo Erreur: Veuillez spécifier un nom pour votre nouveau mod
    echo Exemple: create-new-mod.bat awesome_mod
    exit /b 1
)

REM Récupère le nom du mod
set "MOD_NAME=%~1"
set "MOD_ID=%MOD_NAME%"

REM Convertit les espaces en underscores pour l'ID du mod
set "MOD_ID=%MOD_ID: =_%"

REM Convertit l'ID en minuscules
for %%a in ("A=a" "B=b" "C=c" "D=d" "E=e" "F=f" "G=g" "H=h" "I=i" "J=j" "K=k" "L=l" "M=m" "N=n" "O=o" "P=p" "Q=q" "R=r" "S=s" "T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z") do (
    set "MOD_ID=!MOD_ID:%%~a!"
)

REM Convertit le nom pour les classes Java (CamelCase)
set "CLASS_NAME=%MOD_NAME%"
set "CLASS_NAME=%CLASS_NAME:_= %"
set "CAMEL_CASE="

REM Convertit chaque mot en CamelCase
for %%w in (%CLASS_NAME%) do (
    set "WORD=%%w"
    set "FIRST=!WORD:~0,1!"
    set "REST=!WORD:~1!"
    for %%a in ("a=A" "b=B" "c=C" "d=D" "e=E" "f=F" "g=G" "h=H" "i=I" "j=J" "k=K" "l=L" "m=M" "n=N" "o=O" "p=P" "q=Q" "r=R" "s=S" "t=T" "u=U" "v=V" "w=W" "x=X" "y=Y" "z=Z") do (
        set "FIRST=!FIRST:%%~a!"
    )
    set "CAMEL_CASE=!CAMEL_CASE!!FIRST!!REST!"
)

REM Vérifie si le dossier existe déjà
if exist "..\%MOD_ID%" (
    echo Erreur: Un mod avec ce nom existe déjà: %MOD_ID%
    exit /b 1
)

echo ===============================================
echo     Création du mod: %MOD_NAME%
echo     ID du mod: %MOD_ID%
echo     Nom de classe: %CAMEL_CASE%
echo ===============================================
echo.

echo [1/5] Copie du template...
mkdir "..\%MOD_ID%"
xcopy /E /I /Y "templates\new-mod-template\*" "..\%MOD_ID%\" > nul

echo [2/5] Configuration du mod...
REM Remplacer archives_base_name dans gradle.properties
powershell -Command "(Get-Content '..\%MOD_ID%\gradle.properties') -replace 'archives_base_name=mod_name', 'archives_base_name=%MOD_ID%' | Set-Content '..\%MOD_ID%\gradle.properties'"

echo [3/5] Création de la structure de dossiers...
mkdir "..\%MOD_ID%\src\main\java\com\kraphtea\%MOD_ID%"
mkdir "..\%MOD_ID%\src\main\resources\assets\%MOD_ID%\lang"
mkdir "..\%MOD_ID%\src\main\resources\assets\%MOD_ID%\textures"
mkdir "..\%MOD_ID%\src\main\resources\data\%MOD_ID%"

echo [4/5] Création des fichiers de base...

REM Création de la classe principale
echo package com.kraphtea.%MOD_ID%; > "..\%MOD_ID%\src\main\java\com\kraphtea\%MOD_ID%\%CAMEL_CASE%.java"
echo. >> "..\%MOD_ID%\src\main\java\com\kraphtea\%MOD_ID%\%CAMEL_CASE%.java"
echo import net.fabricmc.api.ModInitializer; >> "..\%MOD_ID%\src\main\java\com\kraphtea\%MOD_ID%\%CAMEL_CASE%.java"
echo import org.apache.logging.log4j.LogManager; >> "..\%MOD_ID%\src\main\java\com\kraphtea\%MOD_ID%\%CAMEL_CASE%.java"
echo import org.apache.logging.log4j.Logger; >> "..\%MOD_ID%\src\main\java\com\kraphtea\%MOD_ID%\%CAMEL_CASE%.java"
echo. >> "..\%MOD_ID%\src\main\java\com\kraphtea\%MOD_ID%\%CAMEL_CASE%.java"
echo public class %CAMEL_CASE% implements ModInitializer { >> "..\%MOD_ID%\src\main\java\com\kraphtea\%MOD_ID%\%CAMEL_CASE%.java"
echo. >> "..\%MOD_ID%\src\main\java\com\kraphtea\%MOD_ID%\%CAMEL_CASE%.java"
echo     public static final String MOD_ID = "%MOD_ID%"; >> "..\%MOD_ID%\src\main\java\com\kraphtea\%MOD_ID%\%CAMEL_CASE%.java"
echo     public static final Logger LOGGER = LogManager.getLogger(MOD_ID); >> "..\%MOD_ID%\src\main\java\com\kraphtea\%MOD_ID%\%CAMEL_CASE%.java"
echo. >> "..\%MOD_ID%\src\main\java\com\kraphtea\%MOD_ID%\%CAMEL_CASE%.java"
echo     @Override >> "..\%MOD_ID%\src\main\java\com\kraphtea\%MOD_ID%\%CAMEL_CASE%.java"
echo     public void onInitialize() { >> "..\%MOD_ID%\src\main\java\com\kraphtea\%MOD_ID%\%CAMEL_CASE%.java"
echo         LOGGER.info("Initializing %MOD_NAME%"); >> "..\%MOD_ID%\src\main\java\com\kraphtea\%MOD_ID%\%CAMEL_CASE%.java"
echo     } >> "..\%MOD_ID%\src\main\java\com\kraphtea\%MOD_ID%\%CAMEL_CASE%.java"
echo } >> "..\%MOD_ID%\src\main\java\com\kraphtea\%MOD_ID%\%CAMEL_CASE%.java"

REM Création du fichier fabric.mod.json
echo { > "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   "schemaVersion": 1, >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   "id": "%MOD_ID%", >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   "version": "${version}", >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   "name": "%MOD_NAME%", >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   "description": "A Fabric mod for Minecraft 1.20.1", >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   "authors": [ >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo     "Kraphtea" >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   ], >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   "contact": { >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo     "homepage": "https://github.com/GingerTeacup/kraphtea-mods", >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo     "issues": "https://github.com/GingerTeacup/kraphtea-mods/issues" >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   }, >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   "license": "MIT", >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   "icon": "assets/%MOD_ID%/icon.png", >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   "environment": "*", >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   "entrypoints": { >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo     "main": [ >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo       "com.kraphtea.%MOD_ID%.%CAMEL_CASE%" >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo     ] >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   }, >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   "depends": { >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo     "fabricloader": ">=${loader_version}", >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo     "fabric-api": ">=${fabric_version}", >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo     "minecraft": "~1.20.1", >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo     "java": ">=17" >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   }, >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   "suggests": { >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo   } >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"
echo } >> "..\%MOD_ID%\src\main\resources\fabric.mod.json"

REM Création du fichier en_us.json
echo { > "..\%MOD_ID%\src\main\resources\assets\%MOD_ID%\lang\en_us.json"
echo   "itemGroup.%MOD_ID%.group": "%MOD_NAME%" >> "..\%MOD_ID%\src\main\resources\assets\%MOD_ID%\lang\en_us.json"
echo } >> "..\%MOD_ID%\src\main\resources\assets\%MOD_ID%\lang\en_us.json"

REM Création du fichier README.md
echo # %MOD_NAME% > "..\%MOD_ID%\README.md"
echo. >> "..\%MOD_ID%\README.md"
echo A Fabric mod for Minecraft 1.20.1 >> "..\%MOD_ID%\README.md"
echo. >> "..\%MOD_ID%\README.md"
echo ## Description >> "..\%MOD_ID%\README.md"
echo. >> "..\%MOD_ID%\README.md"
echo [Description du mod à remplir] >> "..\%MOD_ID%\README.md"
echo. >> "..\%MOD_ID%\README.md"
echo ## Installation >> "..\%MOD_ID%\README.md"
echo. >> "..\%MOD_ID%\README.md"
echo 1. Install [Fabric](https://fabricmc.net/use/) for Minecraft 1.20.1 >> "..\%MOD_ID%\README.md"
echo 2. Download the mod JAR from the releases section >> "..\%MOD_ID%\README.md"
echo 3. Place the JAR in your mods folder >> "..\%MOD_ID%\README.md"
echo 4. Launch Minecraft >> "..\%MOD_ID%\README.md"
echo. >> "..\%MOD_ID%\README.md"
echo ## Features >> "..\%MOD_ID%\README.md"
echo. >> "..\%MOD_ID%\README.md"
echo - [Liste des fonctionnalités à remplir] >> "..\%MOD_ID%\README.md"
echo. >> "..\%MOD_ID%\README.md"
echo ## License >> "..\%MOD_ID%\README.md"
echo. >> "..\%MOD_ID%\README.md"
echo This project is licensed under the MIT License. >> "..\%MOD_ID%\README.md"

REM Création d'un fichier de licence
echo MIT License > "..\%MOD_ID%\LICENSE"
echo. >> "..\%MOD_ID%\LICENSE"
echo Copyright (c) 2025 Kraphtea >> "..\%MOD_ID%\LICENSE"
echo. >> "..\%MOD_ID%\LICENSE"
echo Permission is hereby granted, free of charge, to any person obtaining a copy >> "..\%MOD_ID%\LICENSE"
echo of this software and associated documentation files (the "Software"), to deal >> "..\%MOD_ID%\LICENSE"
echo in the Software without restriction, including without limitation the rights >> "..\%MOD_ID%\LICENSE"
echo to use, copy, modify, merge, publish, distribute, sublicense, and/or sell >> "..\%MOD_ID%\LICENSE"
echo copies of the Software, and to permit persons to whom the Software is >> "..\%MOD_ID%\LICENSE"
echo furnished to do so, subject to the following conditions: >> "..\%MOD_ID%\LICENSE"
echo. >> "..\%MOD_ID%\LICENSE"
echo The above copyright notice and this permission notice shall be included in all >> "..\%MOD_ID%\LICENSE"
echo copies or substantial portions of the Software. >> "..\%MOD_ID%\LICENSE"
echo. >> "..\%MOD_ID%\LICENSE"
echo THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR >> "..\%MOD_ID%\LICENSE"
echo IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, >> "..\%MOD_ID%\LICENSE"
echo FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE >> "..\%MOD_ID%\LICENSE"
echo AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER >> "..\%MOD_ID%\LICENSE"
echo LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, >> "..\%MOD_ID%\LICENSE"
echo OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE >> "..\%MOD_ID%\LICENSE"
echo SOFTWARE. >> "..\%MOD_ID%\LICENSE"

REM Création d'un script de compilation
echo @echo off > "..\%MOD_ID%\compile.bat"
echo. >> "..\%MOD_ID%\compile.bat"
echo REM Exécution du compilateur commun >> "..\%MOD_ID%\compile.bat"
echo call ..\shared-tools\compilation\compile-mod.bat . >> "..\%MOD_ID%\compile.bat"

echo [5/5] Finalisation du projet...
REM Copie des fichiers Gradle
xcopy /Y "..\shared-tools\templates\new-mod-template\gradle\*" "..\%MOD_ID%\gradle\" > nul
copy /Y "..\shared-tools\templates\new-mod-template\gradlew" "..\%MOD_ID%\" > nul
copy /Y "..\shared-tools\templates\new-mod-template\gradlew.bat" "..\%MOD_ID%\" > nul
copy /Y "..\shared-tools\templates\new-mod-template\settings.gradle" "..\%MOD_ID%\" > nul

echo ===============================================
echo       CRÉATION RÉUSSIE!
echo ===============================================
echo.
echo Le mod %MOD_NAME% a été créé avec succès!
echo.
echo === Prochaines étapes ===
echo 1. Personnalisez la description dans README.md
echo 2. Ajoutez votre icône dans src\main\resources\assets\%MOD_ID%\icon.png
echo 3. Commencez à développer votre mod dans src\main\java\com\kraphtea\%MOD_ID%\
echo 4. Pour compiler votre mod, exécutez compile.bat
echo.
echo Bon développement!

exit /b 0