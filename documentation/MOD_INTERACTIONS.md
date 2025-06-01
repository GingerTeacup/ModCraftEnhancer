# Interactions entre les mods Kraphtea

Ce document explique comment les différents mods de la collection Kraphtea fonctionnent ensemble et s'intègrent au modpack.

## Vue d'ensemble

Les mods Kraphtea sont conçus pour fonctionner harmonieusement ensemble, créant une expérience cohérente tout en conservant leur indépendance. L'architecture modulaire permet d'activer ou désactiver chaque mod selon les besoins sans affecter les autres.

## LootrTweaker + Enchantment Disabler

Ces deux mods se complètent particulièrement bien pour équilibrer le gameplay:

### Scénario d'utilisation typique

1. **LootrTweaker** modifie les tables de butin pour ajuster la rareté des objets et ajouter des emplacements vides
2. **Enchantment Disabler** désactive certains enchantements trop puissants
3. Ensemble, ils créent une progression plus équilibrée:
   - Les objets puissants sont plus rares dans les coffres
   - Les enchantements trop avantageux sont désactivés
   - L'expérience de jeu est plus équilibrée et immersive

### Exemple d'équilibrage

Pour créer un défi de survie sous-marine plus difficile:
- Configurer LootrTweaker pour rendre les tridents plus rares dans les coffres des ruines océaniques
- Utiliser Enchantment Disabler pour désactiver les enchantements Respiration et Affinité aquatique
- Résultat: les joueurs doivent gérer leur temps sous l'eau plus stratégiquement

## Intégration au modpack Kraphtea

Les mods ont été spécifiquement développés pour le modpack Kraphtea v1.0.6, avec ces intégrations clés:

### Compatibilité avec Lootr

LootrTweaker s'appuie sur Lootr (v0.7.35.85), un mod populaire qui remplace les coffres vanilla par des coffres avec butin personnalisé par joueur. Notre mod ne remplace pas Lootr mais étend ses fonctionnalités.

### Performance et charge serveur

Les mods sont optimisés pour minimiser leur impact sur les performances:
- Traitement efficient des événements
- Faible empreinte mémoire
- Utilisation optimale du système de cache

### Compatibilité multi-joueurs

Tous les mods fonctionnent côté serveur uniquement, ce qui signifie:
- Les clients n'ont pas besoin d'installer ces mods
- La configuration est centralisée sur le serveur
- Expérience cohérente pour tous les joueurs connectés

## Interactions techniques

### Partage de données entre mods

Bien que chaque mod fonctionne indépendamment, certaines informations peuvent être partagées:

- **Journalisation** - Un système de log centralisé enregistre les activités de tous les mods
- **Cache** - Certaines données peuvent être mises en cache pour optimiser les performances
- **Événements** - Les mods peuvent réagir aux mêmes événements de jeu de manière coordonnée

### Ordre de chargement

L'ordre de chargement optimal des mods est:

1. Fabric API
2. Lootr
3. Enchantment Disabler
4. LootrTweaker

Cet ordre garantit que toutes les dépendances sont satisfaites et que les modifications se produisent dans la séquence appropriée.

## Extension à d'autres mods

La collection Kraphtea est conçue pour être extensible. Voici quelques idées d'intégration future:

### Potentiels nouveaux mods

- **Craft Tweaker** - Modification des recettes pour compléter les changements de butin
- **Mob Scaler** - Ajustement de la difficulté des monstres pour équilibrer les objets et enchantements modifiés
- **Experience Modifier** - Ajustement des gains d'XP pour compenser les changements d'enchantements

### Hooks d'API pour développeurs tiers

Les mods Kraphtea exposent certaines API que les développeurs tiers peuvent utiliser:
- Accès aux configurations de butin
- Événements de modification de loot
- Système de poids des objets

## Conseils d'utilisation combinée

Pour tirer le meilleur parti des mods ensemble:

1. **Configuration cohérente** - Assurez-vous que vos configurations sont cohérentes (par exemple, ne pas désactiver un enchantement que vous avez rendu plus rare)
2. **Progression équilibrée** - Pensez à la courbe de progression du joueur lors de l'ajustement des paramètres
3. **Tests réguliers** - Testez vos configurations pour vous assurer qu'elles produisent l'expérience de jeu souhaitée

## Dépannage des interactions

Si vous rencontrez des problèmes avec l'interaction des mods:

1. Vérifiez que tous les mods sont à jour
2. Consultez les logs pour identifier d'éventuels conflits
3. Essayez de modifier l'ordre de chargement des mods
4. Regardez si d'autres mods du modpack pourraient interférer