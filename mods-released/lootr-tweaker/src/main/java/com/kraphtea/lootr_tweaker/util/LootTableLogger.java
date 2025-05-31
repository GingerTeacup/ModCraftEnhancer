package com.kraphtea.lootr_tweaker.util;

import com.kraphtea.lootr_tweaker.LootrTweaker;
import net.minecraft.loot.LootManager;
import net.minecraft.loot.LootPool;
import net.minecraft.loot.LootTable;
import net.minecraft.loot.entry.LootPoolEntry;
import net.minecraft.server.MinecraftServer;
import net.minecraft.server.world.ServerWorld;
import net.minecraft.util.Identifier;
import net.minecraft.util.WorldSavePath;

import java.io.IOException;
import java.lang.reflect.Field;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.text.SimpleDateFormat;
import java.util.*;

public class LootTableLogger {

    public static void logLootTableWeights() {
        try {
            // Génère un timestamp pour le nom du fichier
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
            String timestamp = dateFormat.format(new Date());
            
            // Crée le répertoire logs s'il n'existe pas
            Path logsDir = Paths.get("logs");
            Files.createDirectories(logsDir);
            
            // Crée un fichier log pour les informations sur les tables de loot
            Path logFile = logsDir.resolve("lootr_tweaker_loot_weights_" + timestamp + ".log");
            Files.createFile(logFile);
            
            // Récupère le serveur et le monde
            MinecraftServer server = getServer();
            if (server == null) {
                LootrTweaker.LOGGER.error("Server not available for logging loot tables");
                return;
            }
            
            // Récupère le LootManager
            LootManager lootManager = server.getLootManager();
            Map<Identifier, LootTable> lootTables = getLootTables(lootManager);
            
            if (lootTables == null || lootTables.isEmpty()) {
                LootrTweaker.LOGGER.error("No loot tables available for logging");
                return;
            }
            
            // Journalise les tables de loot Lootr
            StringBuilder logContent = new StringBuilder();
            logContent.append("=== LootrTweaker Loot Table Weights Log ===\n");
            logContent.append("Generated: ").append(timestamp).append("\n\n");
            
            // Filtre pour obtenir uniquement les tables de loot Lootr
            List<Map.Entry<Identifier, LootTable>> lootrTables = lootTables.entrySet().stream()
                .filter(entry -> entry.getKey().getNamespace().equals("lootr"))
                .sorted(Comparator.comparing(e -> e.getKey().toString()))
                .toList();
            
            logContent.append("Found ").append(lootrTables.size()).append(" Lootr loot tables\n\n");
            
            // Crée un fichier séparé pour chaque table de loot pour éviter les problèmes de mémoire
            for (Map.Entry<Identifier, LootTable> entry : lootrTables) {
                Identifier tableId = entry.getKey();
                LootTable table = entry.getValue();
                
                // Crée un fichier spécifique pour cette table
                Path tableLogFile = logsDir.resolve("lootr_table_" + tableId.getPath().replace('/', '_') + "_" + timestamp + ".log");
                Files.createFile(tableLogFile);
                
                StringBuilder tableContent = new StringBuilder();
                tableContent.append("=== Loot Table: ").append(tableId).append(" ===\n\n");
                
                // Récupère les pools et leurs entrées
                LootPool[] pools = getPools(table);
                if (pools == null || pools.length == 0) {
                    tableContent.append("No pools found in this table\n");
                } else {
                    for (int i = 0; i < pools.length; i++) {
                        LootPool pool = pools[i];
                        tableContent.append("Pool #").append(i).append(":\n");
                        
                        LootPoolEntry[] entries = getEntries(pool);
                        if (entries == null || entries.length == 0) {
                            tableContent.append("  No entries in this pool\n");
                        } else {
                            // Récupère le poids de chaque entrée
                            for (LootPoolEntry entry1 : entries) {
                                int weight = getWeight(entry1);
                                String entryType = entry1.getClass().getSimpleName();
                                tableContent.append("  Entry: ").append(entryType)
                                        .append(", Weight: ").append(weight).append("\n");
                            }
                        }
                        tableContent.append("\n");
                    }
                }
                
                // Écrit le contenu dans le fichier spécifique à cette table
                Files.write(tableLogFile, tableContent.toString().getBytes(), StandardOpenOption.WRITE);
                
                // Ajoute un résumé au fichier principal
                logContent.append("Logged table: ").append(tableId).append(" to file: ")
                        .append(tableLogFile.getFileName()).append("\n");
            }
            
            // Écrit le contenu du résumé dans le fichier principal
            Files.write(logFile, logContent.toString().getBytes(), StandardOpenOption.WRITE);
            
            LootrTweaker.LOGGER.info("Loot table weights logged to {}", logFile);
        } catch (Exception e) {
            LootrTweaker.LOGGER.error("Error logging loot table weights: {}", e.getMessage());
            e.printStackTrace();
        }
    }
    
    private static MinecraftServer getServer() {
        // Ceci est un exemple simplifié; dans un environnement réel,
        // vous devriez obtenir le serveur depuis le contexte approprié
        // Par exemple, via ServerLifecycleEvents ou depuis ServerCommandSource
        return null; // À implémenter correctement dans le code final
    }
    
    // Utilise la réflexion pour accéder aux champs privés
    
    private static Map<Identifier, LootTable> getLootTables(LootManager lootManager) {
        try {
            Field tablesField = lootManager.getClass().getDeclaredField("tables");
            tablesField.setAccessible(true);
            @SuppressWarnings("unchecked")
            Map<Identifier, LootTable> tables = (Map<Identifier, LootTable>) tablesField.get(lootManager);
            return tables;
        } catch (Exception e) {
            LootrTweaker.LOGGER.error("Error accessing loot tables: {}", e.getMessage());
            return null;
        }
    }
    
    private static LootPool[] getPools(LootTable table) {
        try {
            Field poolsField = table.getClass().getDeclaredField("pools");
            poolsField.setAccessible(true);
            return (LootPool[]) poolsField.get(table);
        } catch (Exception e) {
            LootrTweaker.LOGGER.error("Error accessing loot pools: {}", e.getMessage());
            return null;
        }
    }
    
    private static LootPoolEntry[] getEntries(LootPool pool) {
        try {
            Field entriesField = pool.getClass().getDeclaredField("entries");
            entriesField.setAccessible(true);
            return (LootPoolEntry[]) entriesField.get(pool);
        } catch (Exception e) {
            LootrTweaker.LOGGER.error("Error accessing loot entries: {}", e.getMessage());
            return null;
        }
    }
    
    private static int getWeight(LootPoolEntry entry) {
        try {
            Field weightField = entry.getClass().getDeclaredField("weight");
            weightField.setAccessible(true);
            return weightField.getInt(entry);
        } catch (Exception e) {
            LootrTweaker.LOGGER.error("Error accessing entry weight: {}", e.getMessage());
            return 0;
        }
    }
}