package com.kraphtea.artifact_durability;

import com.kraphtea.artifact_durability.component.DurabilityComponents;
import com.kraphtea.artifact_durability.config.ConfigManager;
import com.kraphtea.artifact_durability.listener.TrinketEventListener;
import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.event.lifecycle.v1.ServerLifecycleEvents;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ArtifactDurabilityMod implements ModInitializer {
    public static final String MOD_ID = "artifact_durability";
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);
    
    private static ConfigManager configManager;
    
    @Override
    public void onInitialize() {
        LOGGER.info("Initializing Artifact Durability Mod");
        
        // Initialize components
        DurabilityComponents.register();
        
        // Initialize config
        configManager = new ConfigManager();
        configManager.loadConfig();
        
        // Register event listeners
        TrinketEventListener.register();
        
        // Server lifecycle events
        ServerLifecycleEvents.SERVER_STARTED.register(server -> {
            LOGGER.info("Artifact Durability Mod loaded on server");
        });
        
        LOGGER.info("Artifact Durability Mod initialization complete");
    }
    
    public static ConfigManager getConfigManager() {
        return configManager;
    }
}