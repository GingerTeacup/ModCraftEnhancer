package com.kraphtea.lootr_tweaker;

import com.kraphtea.lootr_tweaker.config.ConfigManager;
import com.kraphtea.lootr_tweaker.events.LootEvents;
import com.kraphtea.lootr_tweaker.commands.LootrTweakerCommands;
import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.command.v2.CommandRegistrationCallback;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class LootrTweaker implements ModInitializer {
    public static final String MOD_ID = "lootr_tweaker";
    public static final Logger LOGGER = LogManager.getLogger(MOD_ID);
    
    @Override
    public void onInitialize() {
        LOGGER.info("Initializing LootrTweaker v1.0.6");
        
        // Charger la configuration
        ConfigManager.init();
        
        // Enregistrer les événements
        LootEvents.registerEvents();
        
        // Enregistrer les commandes
        CommandRegistrationCallback.EVENT.register((dispatcher, registryAccess, environment) -> {
            LootrTweakerCommands.register(dispatcher);
        });
        
        LOGGER.info("LootrTweaker initialized successfully");
    }
}