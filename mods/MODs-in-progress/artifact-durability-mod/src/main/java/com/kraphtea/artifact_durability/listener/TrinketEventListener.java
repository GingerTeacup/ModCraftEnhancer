package com.kraphtea.artifact_durability.listener;

import com.kraphtea.artifact_durability.ArtifactDurabilityMod;
import com.kraphtea.artifact_durability.component.DurabilityComponents;
import com.kraphtea.artifact_durability.component.PlayerDurabilityComponent;
import com.kraphtea.artifact_durability.config.ConfigManager;
import dev.emi.trinkets.api.event.TrinketEquipCallback;
import net.minecraft.entity.LivingEntity;
import net.minecraft.entity.player.PlayerEntity;
import net.minecraft.item.ItemStack;
import net.minecraft.util.Identifier;

public class TrinketEventListener {
    
    public static void register() {
        TrinketEquipCallback.EVENT.register(TrinketEventListener::onTrinketEquip);
        ArtifactDurabilityMod.LOGGER.info("Registered trinket event listeners");
    }
    
    private static void onTrinketEquip(ItemStack stack, LivingEntity entity) {
        if (!(entity instanceof PlayerEntity player)) return;
        
        String itemId = getItemId(stack);
        if (!isArtifact(itemId)) return;
        
        PlayerDurabilityComponent component = DurabilityComponents.DURABILITY_DATA.get(player);
        
        // Si l'artéfact n'a pas encore de durabilité, l'initialiser
        if (!component.hasArtifactDurability(itemId)) {
            ConfigManager config = ArtifactDurabilityMod.getConfigManager();
            int maxDurability = config.getArtifactMaxDurability(itemId);
            component.setArtifactDurability(itemId, maxDurability, maxDurability);
            
            ArtifactDurabilityMod.LOGGER.info("Initialized durability for artifact: {} with durability: {}", 
                itemId, maxDurability);
        }
    }
    
    private static String getItemId(ItemStack stack) {
        Identifier id = stack.getItem().getRegistryEntry().getKey().orElse(null);
        return id != null ? id.toString() : "";
    }
    
    private static boolean isArtifact(String itemId) {
        return itemId.startsWith("artifacts:") || 
               itemId.startsWith("things:") ||
               itemId.startsWith("botania:") ||
               itemId.startsWith("create:") ||
               itemId.contains("trinket") ||
               itemId.contains("artifact");
    }
}