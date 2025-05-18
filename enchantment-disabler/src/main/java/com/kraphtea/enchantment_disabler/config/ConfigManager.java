package com.kraphtea.enchantment_disabler.config;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kraphtea.enchantment_disabler.EnchantmentDisabler;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashSet;
import java.util.Set;

public class ConfigManager {
    private static final String CONFIG_DIR = "config/enchantment_disabler";
    private static final String CONFIG_FILE = "config.json";
    
    private static Config config;
    
    public static void init() {
        createDirectories();
        loadConfig();
    }
    
    private static void createDirectories() {
        try {
            Files.createDirectories(Paths.get(CONFIG_DIR));
        } catch (IOException e) {
            EnchantmentDisabler.LOGGER.error("Failed to create config directory: {}", e.getMessage());
        }
    }
    
    private static void loadConfig() {
        Path configPath = Paths.get(CONFIG_DIR, CONFIG_FILE);
        
        if (!Files.exists(configPath)) {
            config = new Config();
            saveConfig();
            EnchantmentDisabler.LOGGER.info("Created default config file");
        } else {
            try (Reader reader = Files.newBufferedReader(configPath)) {
                config = new Gson().fromJson(reader, Config.class);
                EnchantmentDisabler.LOGGER.info("Loaded config file");
            } catch (Exception e) {
                EnchantmentDisabler.LOGGER.error("Error loading config: {}", e.getMessage());
                config = new Config();
                saveConfig();
            }
        }
    }
    
    private static void saveConfig() {
        Path configPath = Paths.get(CONFIG_DIR, CONFIG_FILE);
        
        try (Writer writer = Files.newBufferedWriter(configPath)) {
            Gson gson = new GsonBuilder().setPrettyPrinting().create();
            gson.toJson(config, writer);
        } catch (IOException e) {
            EnchantmentDisabler.LOGGER.error("Error saving config: {}", e.getMessage());
        }
    }
    
    public static Set<String> getDisabledEnchantments() {
        return config.disabledEnchantments;
    }
    
    public static class Config {
        private Set<String> disabledEnchantments = new HashSet<>();
        
        public Config() {
            // Exemples d'enchantements à désactiver par défaut
            disabledEnchantments.add("minecraft:aqua_affinity");
            disabledEnchantments.add("minecraft:respiration");
        }
    }
}