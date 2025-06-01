@echo off
echo Nettoyage complet du cache Gradle et Loom...

echo Suppression du cache local...
if exist ".gradle" rmdir /s /q ".gradle"
if exist "build" rmdir /s /q "build"

echo Suppression du cache utilisateur Loom...
if exist "%USERPROFILE%\.gradle\caches\fabric-loom" rmdir /s /q "%USERPROFILE%\.gradle\caches\fabric-loom"

echo Nettoyage terminé. Compilation propre...
gradlew clean build --no-daemon --refresh-dependencies

echo Terminé!
pause