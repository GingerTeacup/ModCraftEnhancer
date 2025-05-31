package com.kraphtea.artifact_durability.component;

import dev.onyxstudios.cca.api.v3.component.ComponentV3;
import dev.onyxstudios.cca.api.v3.component.sync.AutoSyncedComponent;
import net.minecraft.entity.player.PlayerEntity;
import net.minecraft.nbt.NbtCompound;
import net.minecraft.nbt.NbtElement;

import java.util.HashMap;
import java.util.Map;

public class PlayerDurabilityComponent implements ComponentV3, AutoSyncedComponent {
    private final PlayerEntity player;
    private final Map<String, Integer> artifactDurability = new HashMap<>();
    private final Map<String, Integer> artifactMaxDurability = new HashMap<>();
    
    public PlayerDurabilityComponent(PlayerEntity player) {
        this.player = player;
    }
    
    public void setArtifactDurability(String artifactId, int currentDurability, int maxDurability) {
        artifactDurability.put(artifactId, currentDurability);
        artifactMaxDurability.put(artifactId, maxDurability);
        DurabilityComponents.DURABILITY_DATA.sync(player);
    }
    
    public int getArtifactDurability(String artifactId) {
        return artifactDurability.getOrDefault(artifactId, -1);
    }
    
    public int getArtifactMaxDurability(String artifactId) {
        return artifactMaxDurability.getOrDefault(artifactId, -1);
    }
    
    public boolean hasArtifactDurability(String artifactId) {
        return artifactDurability.containsKey(artifactId);
    }
    
    public void damageArtifact(String artifactId, int damage) {
        if (artifactDurability.containsKey(artifactId)) {
            int current = artifactDurability.get(artifactId);
            artifactDurability.put(artifactId, Math.max(0, current - damage));
            DurabilityComponents.DURABILITY_DATA.sync(player);
        }
    }
    
    public void repairArtifact(String artifactId, int repair) {
        if (artifactDurability.containsKey(artifactId) && artifactMaxDurability.containsKey(artifactId)) {
            int current = artifactDurability.get(artifactId);
            int max = artifactMaxDurability.get(artifactId);
            artifactDurability.put(artifactId, Math.min(max, current + repair));
            DurabilityComponents.DURABILITY_DATA.sync(player);
        }
    }
    
    @Override
    public void readFromNbt(NbtCompound tag) {
        artifactDurability.clear();
        artifactMaxDurability.clear();
        
        if (tag.contains("durability", NbtElement.COMPOUND_TYPE)) {
            NbtCompound durabilityTag = tag.getCompound("durability");
            for (String key : durabilityTag.getKeys()) {
                artifactDurability.put(key, durabilityTag.getInt(key));
            }
        }
        
        if (tag.contains("max_durability", NbtElement.COMPOUND_TYPE)) {
            NbtCompound maxDurabilityTag = tag.getCompound("max_durability");
            for (String key : maxDurabilityTag.getKeys()) {
                artifactMaxDurability.put(key, maxDurabilityTag.getInt(key));
            }
        }
    }
    
    @Override
    public void writeToNbt(NbtCompound tag) {
        NbtCompound durabilityTag = new NbtCompound();
        for (Map.Entry<String, Integer> entry : artifactDurability.entrySet()) {
            durabilityTag.putInt(entry.getKey(), entry.getValue());
        }
        tag.put("durability", durabilityTag);
        
        NbtCompound maxDurabilityTag = new NbtCompound();
        for (Map.Entry<String, Integer> entry : artifactMaxDurability.entrySet()) {
            maxDurabilityTag.putInt(entry.getKey(), entry.getValue());
        }
        tag.put("max_durability", maxDurabilityTag);
    }
}