# Headshots (OpenMW)

Adds simple headshots.

If you shoot a humanoid in the top of their hitbox, they'll take extra damage. That's the idea.

## Features

### Headshots

To successfully land a headshot, you just need to:

- Hit the enemy in the top of their hitbox (default: top 85%)
- Be far enough from the enemy (default: 1000 units)

You, the player, cannot be headshot. It could be implemented, but I reckon enemy marksman damage is already random enough in the base game.

Creatures (in simple terms, actors who cannot wear armor) cannot be headshot, since I'm not tracking head position and their heads tend to be all over the place.

### Simple Yet Flexible Damage Calculation

Final damage multiplier is a sum of two parts:

1. **Damage multiplier formula**

   - **Linear** -> `FlatMultiplier + AttackerMarksman * MarksmanMultiplier`
   - **Threshold** -> `FlatMultiplier + (AttackerMarksman // step) * MarksmanMultiplier` (`//` = integer division)
   - **Instakill** -> `math.huge` (with exceptions)

2. **Damage multiplier per 1000 units**  
   -> `distance * Dmg/1000units`

So the result is:  
`Final Mult = (Dmg Mult Formula) + (distance * Dmg/1000units)`

### Make Headshots That Suit You!

Everything in the mod is configurable - and I mean it.

- Want simple and reliable headshots? Easy.
- Want to reward positioning more? Sure, go for it.
- Want to instakill, but only from far away? That's possible too.

Default values are just a formality.

## Requirements

OpenMW September 2025 dev build or newer (API version 95+).

## Installation

Install like any other OpenMW mod.

## Compatibility

Yes.

## Other Mods to Enhance Your Headshotting Experience

- [Projectile Overhaul - Modular](https://www.nexusmods.com/morrowind/mods/43195) by **Mr.Magic** - Speeds up your projectiles (in vanilla they're comically slow), boosts ammo recovery chance, and much more.
- [Smart Ammo for OpenMW-Lua](https://www.nexusmods.com/morrowind/mods/51274) by **johnnyhostile** - Lets you auto-equip ammo when you ready your bow or crossbow.
- [Take Cover (OpenMW)](https://www.nexusmods.com/morrowind/mods/54976) by **mym** - Enemies with melee attacks will now try to hide if the player attacks them from an unreachable position.
- [Cast On Strike Bow and Crossbow (OpenMW)](https://www.nexusmods.com/morrowind/mods/57329) by **MomokeCome** - Lets you cast On Strike enchantments with bows and crossbows.
- [Poison Weapons (OpenMW)](https://www.nexusmods.com/morrowind/mods/57257) by **MomokeCome** - Lets you apply poisons (potions or ingredients) to your weapons.

## Credits

Author: **Sosnoviy Bor**

The mod is heavily inspired by [Ranged Headshot](https://modding-openmw.gitlab.io/ranged-headshot/) made by **SkyHasCats** and uses its headshot detection system.