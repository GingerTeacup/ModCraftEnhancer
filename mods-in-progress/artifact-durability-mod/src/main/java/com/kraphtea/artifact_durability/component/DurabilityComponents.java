package com.kraphtea.artifact_durability.component;

import com.kraphtea.artifact_durability.ArtifactDurabilityMod;
import dev.onyxstudios.cca.api.v3.component.ComponentKey;
import dev.onyxstudios.cca.api.v3.component.ComponentRegistryV3;
import dev.onyxstudios.cca.api.v3.entity.EntityComponentFactoryRegistry;
import dev.onyxstudios.cca.api.v3.entity.EntityComponentInitializer;
import net.minecraft.entity.player.PlayerEntity;
import net.minecraft.util.Identifier;

public class DurabilityComponents implements EntityComponentInitializer {
    
    public static final ComponentKey<PlayerDurabilityComponent> DURABILITY_DATA = 
        ComponentRegistryV3.INSTANCE.getOrCreate(
            new Identifier(ArtifactDurabilityMod.MOD_ID, "durability_data"), 
            PlayerDurabilityComponent.class
        );
    
    public static void register() {
        ArtifactDurabilityMod.LOGGER.info("Registering durability components");
    }
    
    @Override
    public void registerEntityComponentFactories(EntityComponentFactoryRegistry registry) {
        registry.registerForPlayers(DURABILITY_DATA, PlayerDurabilityComponent::new);
    }
}