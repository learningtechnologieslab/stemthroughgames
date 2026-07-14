// ============================================================
// BUG 4 – MOB BEHAVIOR NOT WORKING  (BUGGY VERSION)
// MakeCode JavaScript for Minecraft Education Edition
// ============================================================
//
// WHAT THIS IS SUPPOSED TO DO:
//   - A "monster wave" spawner for a survival arena
//   - Every 20 seconds, spawn 3 mobs near the player
//   - Display a wave counter in chat
//   - Mobs should be hostile and chase the player
//
// WHAT ACTUALLY HAPPENS:
//   - Some mobs spawn but immediately vanish
//   - One mob type causes an error / spawns in wrong location
//   - The wave counter works, but the mobs don't behave right
//
// YOUR DEBUGGING CHALLENGE:
//   1. Run the world and wait for the first wave
//   2. Which mobs appear? Which ones immediately vanish?
//   3. Add say("spawning wave " + waveNumber) — does the
//      wave counter work correctly?
//   4. Try spawning each mob type manually with /summon in
//      chat — which ones work? Which ones fail?
//   5. What is wrong with the spawn positions?
// ============================================================

let waveNumber = 0;

loops.everyInterval(20000, function () {  // 20 seconds
    waveNumber = waveNumber + 1;
    player.say("⚠️ Wave " + waveNumber + " incoming!");
    
    // ❌ BUG 1: "Giant" is not available in Minecraft Education Edition
    //    It will silently fail to spawn (or error in some versions)
    mobs.spawn("Giant", pos(0, 0, 0));
    
    // ❌ BUG 2: spawn position is absolute world coordinates (0, 0, 0)
    //    instead of relative to the player (~, ~, ~)
    //    Mobs spawn at world origin, far from the player
    mobs.spawn(MobType.Zombie, pos(0, 0, 0));
    
    // ❌ BUG 3: spawning INSIDE the ground (y offset is -1, underground)
    //    The mob spawns inside a block and suffocates immediately
    mobs.spawn(MobType.Skeleton, positions.add(
        player.position(),
        world(0, -1, 2)
    ));
});
