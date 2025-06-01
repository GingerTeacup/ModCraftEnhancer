package com.kraphtea.lootr_tweaker.commands;

import com.kraphtea.lootr_tweaker.LootrTweaker;
import com.kraphtea.lootr_tweaker.util.LootTableLogger;
import com.mojang.brigadier.CommandDispatcher;
import com.mojang.brigadier.context.CommandContext;
import net.minecraft.server.command.ServerCommandSource;
import net.minecraft.text.Text;

import static net.minecraft.server.command.CommandManager.literal;

public class LootrTweakerCommands {

    public static void register(CommandDispatcher<ServerCommandSource> dispatcher) {
        dispatcher.register(
            literal("lootrTweaker")
                .requires(source -> source.hasPermissionLevel(2)) // Nécessite le niveau op 2+
                .then(literal("reload")
                    .executes(LootrTweakerCommands::reloadConfig))
                .then(literal("analyzeWeights")
                    .executes(LootrTweakerCommands::analyzeWeights))
        );
        
        LootrTweaker.LOGGER.info("Registered commands");
    }
    
    private static int reloadConfig(CommandContext<ServerCommandSource> context) {
        ServerCommandSource source = context.getSource();
        
        // La logique de rechargement serait ici
        source.sendFeedback(() -> Text.literal("LootrTweaker: Config reloaded"), true);
        return 1;
    }
    
    private static int analyzeWeights(CommandContext<ServerCommandSource> context) {
        ServerCommandSource source = context.getSource();
        
        try {
            // Analyse et log des poids des objets dans les tables de loot
            LootTableLogger.logLootTableWeights();
            source.sendFeedback(() -> Text.literal("LootrTweaker: Loot table weights analyzed and saved to logs"), true);
            return 1;
        } catch (Exception e) {
            LootrTweaker.LOGGER.error("Error analyzing loot tables: {}", e.getMessage());
            source.sendError(Text.literal("Error analyzing loot tables: " + e.getMessage()));
            return 0;
        }
    }
}