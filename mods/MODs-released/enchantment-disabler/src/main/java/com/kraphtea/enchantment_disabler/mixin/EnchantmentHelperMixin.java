package com.kraphtea.enchantment_disabler.mixin;

import com.kraphtea.enchantment_disabler.EnchantmentDisabler;
import net.minecraft.enchantment.Enchantment;
import net.minecraft.enchantment.EnchantmentHelper;
import net.minecraft.item.ItemStack;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfoReturnable;

import java.util.Map;

@Mixin(EnchantmentHelper.class)
public class EnchantmentHelperMixin {

    @Inject(method = "getLevel", at = @At("RETURN"), cancellable = true)
    private static void onGetLevel(Enchantment enchantment, ItemStack stack, CallbackInfoReturnable<Integer> cir) {
        if (EnchantmentDisabler.isEnchantmentDisabled(enchantment)) {
            cir.setReturnValue(0);
        }
    }
    
    @Inject(method = "getEnchantmentLevel", at = @At("RETURN"), cancellable = true)
    private static void onGetEnchantmentLevel(Enchantment enchantment, ItemStack stack, CallbackInfoReturnable<Integer> cir) {
        if (EnchantmentDisabler.isEnchantmentDisabled(enchantment)) {
            cir.setReturnValue(0);
        }
    }
    
    @Inject(method = "getPossibleEntries", at = @At("RETURN"), cancellable = true)
    private static void onGetPossibleEntries(int power, ItemStack stack, boolean treasureAllowed, CallbackInfoReturnable<Map<Enchantment, Integer>> cir) {
        Map<Enchantment, Integer> map = cir.getReturnValue();
        map.entrySet().removeIf(entry -> EnchantmentDisabler.isEnchantmentDisabled(entry.getKey()));
    }
}