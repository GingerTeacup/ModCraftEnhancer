# Guide de contribution

Merci de l'intérêt que vous portez à contribuer aux mods Kraphtea ! Ce document fournit des lignes directrices pour contribuer efficacement au projet.

## Processus de contribution

1. **Fork du dépôt** - Créez votre propre fork du dépôt principal
2. **Créez une branche** - `git checkout -b feature/ma-nouvelle-fonctionnalite`
3. **Commitez vos modifications** - `git commit -m 'Ajout d'une nouvelle fonctionnalité'`
4. **Poussez vers la branche** - `git push origin feature/ma-nouvelle-fonctionnalite`
5. **Ouvrez une Pull Request** - Via l'interface GitHub

## Structure du projet

```
kraphtea-mods/
├── shared-tools/                # Outils partagés
├── lootr-tweaker/               # Mod LootrTweaker
├── enchantment-disabler/        # Mod Enchantment Disabler
└── docs/                        # Documentation
```

Chaque mod est autonome et contient sa propre structure de dossiers Fabric standard.

## Création d'un nouveau mod

Utilisez le script `create-new-mod.bat` dans `shared-tools` pour générer rapidement un nouveau mod avec la structure adéquate :

```
cd shared-tools
create-new-mod.bat nom_du_mod
```

## Standards de codage

- **Style de code** - Suivez le style Java standard
- **Nommage** - Utilisez des noms descriptifs en CamelCase pour les classes et méthodes
- **Documentation** - Documentez toutes les classes et méthodes publiques
- **Commentaires** - Écrivez des commentaires pour expliquer le "pourquoi", pas le "quoi"
- **Tests** - Testez votre code avant de soumettre une PR

## Gestion de version

Nous utilisons la gestion sémantique de version (SemVer) :
- MAJEUR.MINEUR.CORRECTIF
- Exemple : 1.2.3

## Processus de revue

1. Un ou plusieurs mainteneurs examineront votre PR
2. Des modifications peuvent être demandées
3. Une fois approuvée, votre PR sera fusionnée

## Signalement de bugs

Si vous trouvez un bug, veuillez créer une issue sur GitHub avec :
- Une description claire du problème
- Les étapes pour reproduire le bug
- Des screenshots si possible
- La version du mod concerné
- L'environnement (versions de Minecraft, Fabric, etc.)

## Suggestions de fonctionnalités

Pour suggérer une nouvelle fonctionnalité :
1. Vérifiez d'abord que cette fonctionnalité n'est pas déjà proposée
2. Ouvrez une issue avec le tag "enhancement"
3. Décrivez clairement la fonctionnalité et son utilité

## Gestion des fichiers volumineux

Nous utilisons Git LFS pour gérer les fichiers volumineux. Voir `docs/git-lfs-guide.md` pour plus d'informations.

## Licence

En contribuant à ce projet, vous acceptez que vos contributions soient publiées sous la même licence que le projet (MIT).

## Contact

Pour toute question, n'hésitez pas à ouvrir une issue GitHub ou à contacter l'équipe Kraphtea directement.