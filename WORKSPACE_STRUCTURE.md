# Structure de l'espace de travail Kraphtea

## Organisation générale

```
kraphtea/
├── mods/                           # Projets de mods Minecraft
│   ├── MODs-released/             # Mods terminés et publiés
│   │   ├── lootr-tweaker/
│   │   └── enchantment-disabler/
│   ├── MODs-in-progress/          # Mods en cours de développement
│   │   └── artifact-durability-mod/
│   ├── MODs-future/               # Idées et projets futurs
│   ├── shared-tools/              # Outils de compilation et utilitaires
│   │   ├── compilation/           # Scripts de compilation
│   │   │   └── compiler-menu.bat  # Menu principal de compilation
│   │   └── templates/             # Templates pour nouveaux mods
│   └── kraphtea-tools.bat         # Menu principal des outils
├── data-packs/                    # Data packs Minecraft
│   ├── DATA-PACK-realese/
│   ├── DATA-PACK-in-progress/
│   └── DATA-PACK-future/
├── shared-tools/                  # Outils généraux du workspace
└── documentation/                 # Documentation générale
```

## Programme principal de compilation

- **Fichier principal** : `kraphtea/mods/kraphtea-tools.bat`
- **Menu de compilation** : `kraphtea/mods/shared-tools/compilation/compiler-menu.bat`

### Options disponibles :
1. Compiler lootr-tweaker
2. Compiler enchantment-disabler  
3. Compiler artifact-durability-mod (en cours)
4. Compiler tous les mods
5. Vérifier l'environnement
6. Quitter

## État actuel

✅ **Synchronisation GitHub** : Fonctionnelle  
✅ **Structure organisée** : Tous les projets dans la bonne hiérarchie  
✅ **Outils de compilation** : Chemins corrigés et fonctionnels  
🔄 **Artifact Durability Mod** : En cours de compilation  

## Instructions mises à jour

- Toujours utiliser l'arborescence existante dans `kraphtea/`
- Corriger les chemins d'accès lors de modifications de structure
- Placer les nouveaux projets dans les dossiers appropriés selon leur état