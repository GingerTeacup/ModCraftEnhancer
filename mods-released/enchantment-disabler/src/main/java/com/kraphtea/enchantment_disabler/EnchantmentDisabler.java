package com.kraphtea.enchantment_disabler;

import com.kraphtea.enchantment_disabler.config.ConfigManager;
import net.fabricmc.api.ModInitializer;
import net.minecraft.enchantment.Enchantment;
import net.minecraft.registry.Registries;
import net.minecraft.util.Identifier;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class EnchantmentDisabler implements ModInitializer {
    public static final String MOD_ID = "enchantment_disabler";
    public static final Logger LOGGER = LogManager.getLogger(MOD_ID);
    
    private static final Map<String, Enchantment> disabledEnchantments = new HashMap<>();
    
    @Override
    public void onInitialize() {
        LOGGER.info("Initializing Enchantment Disabler");
        
        // Charger la configuration
        ConfigManager.init();
        
        // Récupérer la liste des enchantements à désactiver
        Set<String> enchantsToDisable = ConfigManager.getDisabledEnchantments();
        
        // Désactiver les enchantements spécifiés
        if (enchantsToDisable != null && !enchantsToDisable.isEmpty()) {
            for (String enchantId : enchantsToDisable) {
                disableEnchantment(enchantId);
            }
            
            LOGGER.info("Disabled {} enchantments", disabledEnchantments.size());
        } else {
            LOGGER.info("No enchantments to disable");
        }
    }
    
    private void disableEnchantment(String enchantId) {
        try {
            Identifier id = new Identifier(enchantId);
            Enchantment enchantment = Registries.ENCHANTMENT.get(id);
            
            if (enchantment != null) {
                disabledEnchantments.put(enchantId, enchantment);
                LOGGER.info("Disabled enchantment: {}", enchantId);
            } else {
                LOGGER.warn("Could not find enchantment: {}", enchantId);
            }
        } catch (Exception e) {
            LOGGER.error("Error disabling enchantment {}: {}", enchantId, e.getMessage());
        }
    }
    
    /**
     * Vérifie si un enchantement est désactivé.
     * 
     * @param enchantment L'enchantement à vérifier
     * @return true si l'enchantement est désactivé, false sinon
     */
    public static boolean isEnchantmentDisabled(Enchantment enchantment) {
        String id = Registries.ENCHANTMENT.getId(enchantment).toString();
        return disabledEnchantments.containsKey(id);
    }
}