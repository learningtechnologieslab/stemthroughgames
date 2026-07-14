// ============================================================
// BUG 4 – MOB BEHAVIOR NOT WORKING  (FIXED VERSION)
// MakeCode JavaScript for Minecraft Education Edition
// ============================================================
//
// THE FIXES:
//   1. "Giant" → MobType.Zombie (Giant not in Education Edition)
//   2. pos(0,0,0) → relative offsets from player position
//   3. y offset -1 (underground) → y offset +1 (above ground)
//
// KEY CONCEPTS:
//   - pos(x, y, z) uses ABSOLUTE world coordinates
//   - positions.add(player.position(), world(x,y,z)) uses
//     RELATIVE coordinates — offset from the player
//   - y = 0 is the player's feet; y = 1 is one block above
//   - Mobs spawned inside blocks suffocate instantly
//
// DEBUGGING STRATEGY USED:
//   Each mob type was tested with /summon in chat.
//   "Giant" immediately showed as unknown.
//   Adding say("player pos: " + player.position()) revealed
//   that pos(0,0,0) was far from the player.
//   A test zombie spawned at y-1 died instantly — visible in
//   the death message in chat.
// ============================================================

let waveNumber = 0;

// Helper: spawn a mob relative to the player at a safe height
function spawnNearPlayer(mobType, xOffset, zOffset) {
    let spawnPos = positions.add(
        player.position(),
        world(xOffset, 1, zOffset)  // ✅ y=1: one block ABOVE ground, never underground
    );
    mobs.spawn(mobType, spawnPos);
    
    // say("DEBUG: spawned " + mobType + " at offset " + xOffset + ", " + zOffset)
}

loops.everyInterval(20000, function () {  // 20 seconds
    waveNumber = waveNumber + 1;
    player.say("⚠️ Wave " + waveNumber + " incoming!");
    
    // ✅ FIX 1: Use mob types available in Education Edition
    spawnNearPlayer(MobType.Zombie, 3, 0);
    
    // ✅ FIX 2: Relative positions — mobs appear near the player
    spawnNearPlayer(MobType.Skeleton, -3, 0);
    
    // ✅ FIX 3: y offset of +1 puts mobs safely above ground
    spawnNearPlayer(MobType.Spider, 0, 3);
    
    // Scale difficulty with wave number
    if (waveNumber >= 3) {
        spawnNearPlayer(MobType.Creeper, 2, 2);
        player.say("💀 Harder wave — stay alert!");
    }
});

// ============================================================
// EDUCATION EDITION MOB REFERENCE (common hostile mobs):
//   MobType.Zombie         ✅ available
//   MobType.Skeleton       ✅ available  
//   MobType.Spider         ✅ available
//   MobType.Creeper        ✅ available
//   MobType.Witch          ✅ available
//   MobType.Blaze          ✅ available (in Nether)
//   "Giant"                ❌ NOT in Education Edition
//   "Illusioner"           ❌ NOT in Education Edition
//   MobType.Ender_dragon   ⚠️  summons at specific location only
// ============================================================
