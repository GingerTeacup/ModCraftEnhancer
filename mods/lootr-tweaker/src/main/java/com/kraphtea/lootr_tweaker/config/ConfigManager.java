package com.kraphtea.lootr_tweaker.config;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kraphtea.lootr_tweaker.LootrTweaker;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

public class ConfigManager {
    private static final String CONFIG_DIR = "config/lootr_tweaker";
    private static final String GLOBAL_CONFIG_FILE = "global_settings.json";
    private static final String TABLES_DIR = "loot_tables";
    
    private static GlobalConfig globalConfig;
    private static Map<String, LootTableConfig> lootTableConfigs = new HashMap<>();
    
    public static void init() {
        createDirectories();
        loadGlobalConfig();
        loadLootTableConfigs();
    }
    
    private static void createDirectories() {
        try {
            Files.createDirectories(Paths.get(CONFIG_DIR));
            Files.createDirectories(Paths.get(CONFIG_DIR, TABLES_DIR));
        } catch (IOException e) {
            LootrTweaker.LOGGER.error("Failed to create config directories: {}", e.getMessage());
        }
    }
    
    private static void loadGlobalConfig() {
        Path configPath = Paths.get(CONFIG_DIR, GLOBAL_CONFIG_FILE);
        
        if (!Files.exists(configPath)) {
            globalConfig = new GlobalConfig();
            saveGlobalConfig();
            LootrTweaker.LOGGER.info("Created default global config file");
        } else {
            try (Reader reader = Files.newBufferedReader(configPath)) {
                globalConfig = new Gson().fromJson(reader, GlobalConfig.class);
                LootrTweaker.LOGGER.info("Loaded global config file");
            } catch (Exception e) {
                LootrTweaker.LOGGER.error("Error loading global config: {}", e.getMessage());
                globalConfig = new GlobalConfig();
                saveGlobalConfig();
            }
        }
    }
    
    private static void saveGlobalConfig() {
        Path configPath = Paths.get(CONFIG_DIR, GLOBAL_CONFIG_FILE);
        
        try (Writer writer = Files.newBufferedWriter(configPath)) {
            Gson gson = new GsonBuilder().setPrettyPrinting().create();
            gson.toJson(globalConfig, writer);
        } catch (IOException e) {
            LootrTweaker.LOGGER.error("Error saving global config: {}", e.getMessage());
        }
    }
    
    private static void loadLootTableConfigs() {
        Path tablesDir = Paths.get(CONFIG_DIR, TABLES_DIR);
        
        try {
            Files.list(tablesDir)
                .filter(path -> path.toString().endsWith(".json"))
                .forEach(path -> {
                    try (Reader reader = Files.newBufferedReader(path)) {
                        String fileName = path.getFileName().toString();
                        String tableName = fileName.substring(0, fileName.length() - 5); // Remove .json
                        
                        JsonObject jsonObject = JsonParser.parseReader(reader).getAsJsonObject();
                        LootTableConfig config = new Gson().fromJson(jsonObject, LootTableConfig.class);
                        
                        lootTableConfigs.put(tableName, config);
                        LootrTweaker.LOGGER.debug("Loaded config for loot table: {}", tableName);
                    } catch (Exception e) {
                        LootrTweaker.LOGGER.error("Error loading loot table config {}: {}", 
                                path.getFileName(), e.getMessage());
                    }
                });
            
            LootrTweaker.LOGGER.info("Loaded {} loot table configs", lootTableConfigs.size());
        } catch (IOException e) {
            LootrTweaker.LOGGER.error("Error scanning loot table configs: {}", e.getMessage());
        }
    }
    
    public static GlobalConfig getGlobalConfig() {
        return globalConfig;
    }
    
    public static LootTableConfig getLootTableConfig(String tableName) {
        return lootTableConfigs.getOrDefault(tableName, null);
    }
    
    public static boolean hasSpecificConfig(String tableName) {
        return lootTableConfigs.containsKey(tableName);
    }
    
    public static class GlobalConfig {
        private double emptySlotRatio = 0.3; // 30% des slots sont vides par défaut
        private int maxEmptySlots = 4; // Maximum 4 slots vides par défaut
        private Map<String, Double> itemWeights = new HashMap<>();
        private List<String> removedItems = new ArrayList<>();
        private Map<String, List<String>> additionalItems = new HashMap<>();
        
        public double getEmptySlotRatio() {
            return emptySlotRatio;
        }
        
        public int getMaxEmptySlots() {
            return maxEmptySlots;
        }
        
        public Map<String, Double> getItemWeights() {
            return itemWeights;
        }
        
        public List<String> getRemovedItems() {
            return removedItems;
        }
        
        public Map<String, List<String>> getAdditionalItems() {
            return additionalItems;
        }
    }
    
    public static class LootTableConfig {
        private double emptySlotRatio = -1; // -1 signifie "utiliser la valeur globale"
        private int maxEmptySlots = -1; // -1 signifie "utiliser la valeur globale"
        private Map<String, Double> itemWeights = new HashMap<>();
        private List<String> removedItems = new ArrayList<>();
        private List<String> additionalItems = new ArrayList<>();
        
        public double getEmptySlotRatio() {
            return emptySlotRatio;
        }
        
        public int getMaxEmptySlots() {
            return maxEmptySlots;
        }
        
        public Map<String, Double> getItemWeights() {
            return itemWeights;
        }
        
        public List<String> getRemovedItems() {
            return removedItems;
        }
        
        public List<String> getAdditionalItems() {
            return additionalItems;
        }
    }
}