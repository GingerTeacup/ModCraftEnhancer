package com.kraphtea.lootr_tweaker.events;

import com.kraphtea.lootr_tweaker.LootrTweaker;
import com.kraphtea.lootr_tweaker.config.ConfigManager;
import com.kraphtea.lootr_tweaker.config.ConfigManager.GlobalConfig;
import com.kraphtea.lootr_tweaker.config.ConfigManager.LootTableConfig;
import net.fabricmc.fabric.api.loot.v2.LootTableEvents;
import net.minecraft.item.Item;
import net.minecraft.item.ItemStack;
import net.minecraft.loot.LootPool;
import net.minecraft.loot.LootTable;
import net.minecraft.loot.entry.EmptyEntry;
import net.minecraft.loot.entry.ItemEntry;
import net.minecraft.loot.function.SetCountLootFunction;
import net.minecraft.loot.provider.number.ConstantLootNumberProvider;
import net.minecraft.registry.Registries;
import net.minecraft.util.Identifier;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class LootEvents {

    public static void registerEvents() {
        LootTableEvents.MODIFY.register((resourceManager, lootManager, id, tableBuilder, source) -> {
            // Vérifier si le LootTable provient du mod Lootr
            if (id.getNamespace().equals("lootr")) {
                modifyLootTable(id, tableBuilder);
            }
        });
        
        LootrTweaker.LOGGER.info("Registered loot table modification events");
    }
    
    private static void modifyLootTable(Identifier tableId, LootTable.Builder tableBuilder) {
        String tableName = tableId.toString();
        LootrTweaker.LOGGER.debug("Modifying loot table: {}", tableName);
        
        // Récupérer la configuration globale
        GlobalConfig globalConfig = ConfigManager.getGlobalConfig();
        
        // Vérifier s'il existe une configuration spécifique pour cette table
        boolean hasSpecificConfig = ConfigManager.hasSpecificConfig(tableName);
        LootTableConfig tableConfig = hasSpecificConfig ? ConfigManager.getLootTableConfig(tableName) : null;
        
        // Déterminer les paramètres à utiliser
        double emptySlotRatio = (hasSpecificConfig && tableConfig.getEmptySlotRatio() >= 0)
                ? tableConfig.getEmptySlotRatio() : globalConfig.getEmptySlotRatio();
                
        int maxEmptySlots = (hasSpecificConfig && tableConfig.getMaxEmptySlots() >= 0)
                ? tableConfig.getMaxEmptySlots() : globalConfig.getMaxEmptySlots();
        
        Map<String, Double> itemWeights = new HashMap<>(globalConfig.getItemWeights());
        List<String> removedItems = new ArrayList<>(globalConfig.getRemovedItems());
        
        // Ajouter ou remplacer par les valeurs spécifiques à la table
        if (hasSpecificConfig) {
            itemWeights.putAll(tableConfig.getItemWeights());
            removedItems.addAll(tableConfig.getRemovedItems());
        }
        
        // Créer un nouveau pool pour les items modifiés
        LootPool.Builder modifiedPoolBuilder = LootPool.builder();
        
        // Ajouter des emplacements vides selon le ratio configuré
        double totalWeight = 0.0;
        int itemCount = 0;
        
        // Calculer le poids total pour déterminer le nombre d'emplacements vides
        for (Map.Entry<String, Double> entry : itemWeights.entrySet()) {
            if (!removedItems.contains(entry.getKey())) {
                totalWeight += entry.getValue();
                itemCount++;
            }
        }
        
        if (itemCount > 0) {
            // Calculer le nombre d'emplacements vides à ajouter
            double emptySlotWeight = totalWeight * emptySlotRatio / (1.0 - emptySlotRatio);
            int emptySlots = Math.min((int) Math.ceil(emptySlotWeight), maxEmptySlots);
            
            LootrTweaker.LOGGER.debug("Adding {} empty slots to table {}", emptySlots, tableName);
            
            // Ajouter les emplacements vides
            for (int i = 0; i < emptySlots; i++) {
                modifiedPoolBuilder.with(EmptyEntry.builder().weight(1));
            }
            
            // Ajouter les items avec leurs poids configurés
            for (Map.Entry<String, Double> entry : itemWeights.entrySet()) {
                if (!removedItems.contains(entry.getKey())) {
                    try {
                        Identifier itemId = new Identifier(entry.getKey());
                        Item item = Registries.ITEM.get(itemId);
                        
                        if (item != null) {
                            modifiedPoolBuilder.with(
                                ItemEntry.builder(item)
                                    .weight((int) Math.ceil(entry.getValue()))
                                    .apply(SetCountLootFunction.builder(ConstantLootNumberProvider.create(1)))
                            );
                        } else {
                            LootrTweaker.LOGGER.warn("Unknown item in config: {}", entry.getKey());
                        }
                    } catch (Exception e) {
                        LootrTweaker.LOGGER.error("Error adding item {} to loot table: {}", entry.getKey(), e.getMessage());
                    }
                }
            }
            
            // Ajouter des items supplémentaires spécifiques à cette table
            if (hasSpecificConfig) {
                for (String itemId : tableConfig.getAdditionalItems()) {
                    try {
                        Identifier id = new Identifier(itemId);
                        Item item = Registries.ITEM.get(id);
                        
                        if (item != null) {
                            modifiedPoolBuilder.with(
                                ItemEntry.builder(item)
                                    .weight(1)
                                    .apply(SetCountLootFunction.builder(ConstantLootNumberProvider.create(1)))
                            );
                        } else {
                            LootrTweaker.LOGGER.warn("Unknown additional item: {}", itemId);
                        }
                    } catch (Exception e) {
                        LootrTweaker.LOGGER.error("Error adding additional item {} to loot table: {}", itemId, e.getMessage());
                    }
                }
            }
            
            // Ajouter des items supplémentaires globaux destinés à cette table
            Map<String, List<String>> globalAdditionalItems = globalConfig.getAdditionalItems();
            if (globalAdditionalItems.containsKey(tableName)) {
                for (String itemId : globalAdditionalItems.get(tableName)) {
                    try {
                        Identifier id = new Identifier(itemId);
                        Item item = Registries.ITEM.get(id);
                        
                        if (item != null) {
                            modifiedPoolBuilder.with(
                                ItemEntry.builder(item)
                                    .weight(1)
                                    .apply(SetCountLootFunction.builder(ConstantLootNumberProvider.create(1)))
                            );
                        } else {
                            LootrTweaker.LOGGER.warn("Unknown global additional item: {}", itemId);
                        }
                    } catch (Exception e) {
                        LootrTweaker.LOGGER.error("Error adding global additional item {} to loot table: {}", 
                                itemId, e.getMessage());
                    }
                }
            }
            
            // Remplacer le pool principal
            tableBuilder.pool(modifiedPoolBuilder);
        } else {
            LootrTweaker.LOGGER.warn("No valid items for loot table: {}", tableName);
        }
    }
}