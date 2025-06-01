package com.kraphtea.artifact_durability.config;

import java.util.HashMap;
import java.util.Map;

public class ConfigManager {
    private final Map<String, Integer> artifactDurabilityMap = new HashMap<>();
    private boolean enableDurabilityLoss = true;
    private int defaultDurability = 2700; // 45 hours in minutes
    
    public void loadConfig() {
        // Initialize default values for known artifacts
        artifactDurabilityMap.put("artifacts:superstitious_hat", 2700);
        artifactDurabilityMap.put("artifacts:plastic_drinking_hat", 2700);
        artifactDurabilityMap.put("artifacts:villager_hat", 2700);
        artifactDurabilityMap.put("artifacts:cowboy_hat", 2700);
        artifactDurabilityMap.put("artifacts:top_hat", 2700);
        artifactDurabilityMap.put("artifacts:novelty_drinking_hat", 2700);
        artifactDurabilityMap.put("artifacts:night_vision_goggles", 2700);
        artifactDurabilityMap.put("artifacts:snorkel", 2700);
        artifactDurabilityMap.put("artifacts:angler_hat", 2700);
        artifactDurabilityMap.put("artifacts:lucky_scarf", 2700);
        artifactDurabilityMap.put("artifacts:scarf_of_invisibility", 2700);
        artifactDurabilityMap.put("artifacts:cross_necklace", 2700);
        artifactDurabilityMap.put("artifacts:panic_necklace", 2700);
        artifactDurabilityMap.put("artifacts:shock_pendant", 2700);
        artifactDurabilityMap.put("artifacts:flame_pendant", 2700);
        artifactDurabilityMap.put("artifacts:thorn_pendant", 2700);
        artifactDurabilityMap.put("artifacts:charm_of_sinking", 2700);
        artifactDurabilityMap.put("artifacts:cloud_in_a_bottle", 2700);
        artifactDurabilityMap.put("artifacts:obsidian_skull", 2700);
        artifactDurabilityMap.put("artifacts:antidote_vessel", 2700);
        artifactDurabilityMap.put("artifacts:universal_attractor", 2700);
        artifactDurabilityMap.put("artifacts:crystal_heart", 2700);
        artifactDurabilityMap.put("artifacts:helium_flamingo", 2700);
        artifactDurabilityMap.put("artifacts:chorus_totem", 2700);
        artifactDurabilityMap.put("artifacts:pocket_piston", 2700);
        artifactDurabilityMap.put("artifacts:kitty_slippers", 2700);
        artifactDurabilityMap.put("artifacts:bunny_hoppers", 2700);
        artifactDurabilityMap.put("artifacts:running_shoes", 2700);
        artifactDurabilityMap.put("artifacts:steadfast_spikes", 2700);
        artifactDurabilityMap.put("artifacts:flippers", 2700);
        artifactDurabilityMap.put("artifacts:power_glove", 2700);
        artifactDurabilityMap.put("artifacts:fire_gauntlet", 2700);
        artifactDurabilityMap.put("artifacts:pocket_anvil", 2700);
        artifactDurabilityMap.put("artifacts:feral_claws", 2700);
        artifactDurabilityMap.put("artifacts:golden_hook", 2700);
        artifactDurabilityMap.put("artifacts:onion_ring", 2700);
        artifactDurabilityMap.put("artifacts:ring_of_regeneration", 2700);
        artifactDurabilityMap.put("artifacts:whoopee_cushion", 2700);
        artifactDurabilityMap.put("artifacts:umbrella", 2700);
        
        // Things mod artifacts
        artifactDurabilityMap.put("things:displacement_tome", 2700);
        artifactDurabilityMap.put("things:moss_necklace", 2700);
        artifactDurabilityMap.put("things:luck_of_the_irish", 2700);
        artifactDurabilityMap.put("things:riot_gauntlet", 2700);
        artifactDurabilityMap.put("things:arm_extender", 2700);
        artifactDurabilityMap.put("things:mining_gloves", 2700);
        artifactDurabilityMap.put("things:sock", 2700);
        artifactDurabilityMap.put("things:hades_crystal", 2700);
        artifactDurabilityMap.put("things:rabbit_foot", 2700);
        artifactDurabilityMap.put("things:empty_jar", 2700);
        artifactDurabilityMap.put("things:enchanted_wax_gland", 2700);
        artifactDurabilityMap.put("things:infernal_scepter", 2700);
        artifactDurabilityMap.put("things:placebo", 2700);
        artifactDurabilityMap.put("things:bater_wucket", 2700);
        artifactDurabilityMap.put("things:recall_potion", 2700);
        artifactDurabilityMap.put("things:hardening_catalyst", 2700);
        artifactDurabilityMap.put("things:gleaming_powder", 2700);
        artifactDurabilityMap.put("things:container_key", 2700);
        artifactDurabilityMap.put("things:item_magnet", 2700);
        artifactDurabilityMap.put("things:socks", 2700);
        artifactDurabilityMap.put("things:monocle", 2700);
        artifactDurabilityMap.put("things:fastening_tool", 2700);
        artifactDurabilityMap.put("things:broken_watch", 2700);
        artifactDurabilityMap.put("things:cake_dough", 2700);
    }
    
    public int getArtifactMaxDurability(String artifactId) {
        return artifactDurabilityMap.getOrDefault(artifactId, defaultDurability);
    }
    
    public boolean isDurabilityLossEnabled() {
        return enableDurabilityLoss;
    }
    
    public int getDefaultDurability() {
        return defaultDurability;
    }
}