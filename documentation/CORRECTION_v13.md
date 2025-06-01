# Version 13 - Corrections complètes

## Problèmes identifiés et corrigés

### Menu principal kraphtea-tools.bat
- **Appel incorrect** : Corrigé `compiler-menu.bat` vers `compiler-menu-v4.bat`
- **Encodage ajouté** : `chcp 65001` pour les caractères spéciaux
- **Navigation corrigée** : `cd /d "%~dp0"` pour assurer le bon répertoire
- **Chemins relatifs** : Correction des appels vers les sous-scripts

### Nettoyage fichiers obsolètes
- Suppression de tous les anciens scripts de compilation (compile-*.bat)
- Suppression des versions obsolètes de compiler-menu
- Nettoyage du dossier export dans compilation/

### Interface améliorée
- Couleurs ajoutées au menu principal
- Messages d'état colorés
- Meilleure visibilité des options

### Script de test ajouté
- Nouveau fichier `test-menu.bat` pour diagnostic
- Vérifie l'existence des fichiers requis
- Teste l'appel du menu de compilation

## Structure finale propre
```
shared-tools/
├── kraphtea-tools.bat (menu principal)
├── test-menu.bat (diagnostic)
├── create-new-mod.bat
├── compilation/
│   └── compiler-menu-v4.bat (seule version active)
└── export/
    └── kraphtea-tools-v13.tar.gz
```

Le menu principal devrait maintenant fonctionner correctement avec l'option 1.