# EnchantmentDisabler - Planned Features

This document outlines upcoming features planned for the EnchantmentDisabler mod.

## Enchantment Level Control

### Level Capping System
- **Maximum level limits**: Cap enchantments at specific levels (e.g., Sharpness III instead of V)
- **Selective level filtering**: Allow only specific levels of enchantments (e.g., only Sharpness III and V, but not I, II, or IV)
- **Level probability weighting**: Adjust probability of each enchantment level appearing

## Contextual Enchantment Rules

### Environmental Restrictions
- **Dimension-specific rules**: Disable or modify enchantments in specific dimensions
  - Nether-specific enchantment rules
  - End-specific enchantment rules
  - Custom dimension support

### Item Type Restrictions
- **Item category rules**: Disable enchantments on specific item types
  - Example: Disable Looting on bows
  - Example: Limit Efficiency to specific tool types
- **Material-based restrictions**: Different rules for wood, stone, iron, diamond, etc.

## Enchantment Economy Adjustments

### Cost Modification System
- **XP cost multipliers**: Make certain enchantments more expensive in terms of XP levels
- **Material cost adjustments**: Change anvil repair/combine costs for enchanted items
- **Global master switch**: Toggle feature on/off for mod compatibility (default: off)

## Enhanced Compatibility Rules

### Conflict Management
- **Custom incompatibility matrix**: Configure which enchantments cannot appear together
- **Conditional conflicts**: Enchantments that conflict only under specific conditions
  - Example: Conflicts only on specific item types
  - Example: Conflicts only above certain levels

## Effectiveness Modification

### Power Scaling System
- **Percentage effectiveness**: Reduce enchantment power by percentage (e.g., Efficiency at 80%)
- **Custom scaling formulas**: Configure how enchantment effects scale with level
- **Situational effectiveness**: Different effectiveness in different situations

## Temporal Enchantment System

### Degradation Mechanics
- **Usage-based degradation**: Enchantments wear off after X uses
- **Time-based degradation**: Enchantments that expire after X in-game days
- **Power tag system**: Hidden "power" tag (0-1 value) that affects enchantment effectiveness
  - Effectiveness formula: base effect × config multiplier × power tag value

### Enchantment Maintenance
- **Power regeneration**: Methods to restore the "power" tag value 
  - XP-based restoration
  - Special items for restoration
  - Ritual/crafting-based restoration
- **Visual indicators**: Show enchantment power/durability on items

## Integration & Compatibility

### External Mod Support
- **Anvil mod compatibility**: Compatible with mods that change anvil mechanics
- **Enchantment mod compatibility**: Support for modded enchantments
- **API for other mods**: Allow other mods to register custom enchantment rules

---

*Note: Features may be implemented in any order based on development priorities and community feedback.*