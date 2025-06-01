# Version 2.3 - Normalisation des noms de fichiers

## Renommage effectué selon instructions principales

### Fichiers avec noms normaux
- `kraphtea-main.bat` (menu principal)
- `mod-creator.bat` (création de mods)
- `mod-compiler.bat` (compilation)

### Versions stockées dans le code
- Ligne "Version: v2.3" ajoutée dans chaque fichier
- Plus de versioning dans les noms de fichiers
- Cohérence avec les standards de développement

### Références corrigées
- Tous les appels mis à jour vers les nouveaux noms
- Chemins d'erreur corrigés
- Messages de debug cohérents

### Structure finale normalisée
```
shared-tools/
├── kraphtea-main.bat
├── mod-creator.bat
├── compilation/
│   └── mod-compiler.bat
├── github/ (scripts sync)
├── templates/ (modèles)
└── export/
    └── kraphtea-tools-v2.3.tar.gz
```

Les fichiers ont maintenant des noms propres et professionnels, avec la version stockée dans une ligne dédiée du programme comme demandé.