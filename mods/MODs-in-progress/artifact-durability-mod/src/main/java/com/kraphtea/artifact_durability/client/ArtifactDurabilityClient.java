package com.kraphtea.artifact_durability.client;

import com.kraphtea.artifact_durability.ArtifactDurabilityMod;
import com.kraphtea.artifact_durability.component.DurabilityComponents;
import com.kraphtea.artifact_durability.component.PlayerDurabilityComponent;
import net.fabricmc.api.ClientModInitializer;
import net.fabricmc.fabric.api.client.item.v1.ItemTooltipCallback;
import net.minecraft.client.MinecraftClient;
import net.minecraft.entity.player.PlayerEntity;
import net.minecraft.item.ItemStack;
import net.minecraft.text.Text;
import net.minecraft.util.Formatting;
import net.minecraft.util.Identifier;

public class ArtifactDurabilityClient implements ClientModInitializer {
    
    @Override
    public void onInitializeClient() {
        ArtifactDurabilityMod.LOGGER.info("Initializing Artifact Durability Client");
        
        // Register tooltip callback
        ItemTooltipCallback.EVENT.register(this::addDurabilityTooltip);
        
        ArtifactDurabilityMod.LOGGER.info("Artifact Durability Client initialization complete");
    }
    
    private void addDurabilityTooltip(ItemStack stack, ItemTooltipCallback.Context context, java.util.List<Text> tooltip) {
        MinecraftClient client = MinecraftClient.getInstance();
        PlayerEntity player = client.player;
        
        if (player == null) return;
        
        String itemId = getItemId(stack);
        if (!isArtifact(itemId)) return;
        
        PlayerDurabilityComponent component = DurabilityComponents.DURABILITY_DATA.get(player);
        
        if (component.hasArtifactDurability(itemId)) {
            int current = component.getArtifactDurability(itemId);
            int max = component.getArtifactMaxDurability(itemId);
            
            Formatting color = getDurabilityColor(current, max);
            
            tooltip.add(Text.literal("Durabilité: " + current + "/" + max)
                .formatted(color));
        }
    }
    
    private String getItemId(ItemStack stack) {
        Identifier id = stack.getItem().getRegistryEntry().getKey().orElse(null);
        return id != null ? id.toString() : "";
    }
    
    private boolean isArtifact(String itemId) {
        return itemId.startsWith("artifacts:") || 
               itemId.startsWith("things:") ||
               itemId.startsWith("botania:") ||
               itemId.startsWith("create:") ||
               itemId.contains("trinket") ||
               itemId.contains("artifact");
    }
    
    private Formatting getDurabilityColor(int current, int max) {
        double percentage = (double) current / max;
        
        if (percentage > 0.6) {
            return Formatting.GREEN;
        } else if (percentage > 0.3) {
            return Formatting.YELLOW;
        } else {
            return Formatting.RED;
        }
    }
}