// ============================================================
// BONUS: COMPLETE MINI-GAME EXAMPLE
// "Diamond Rush" – A working reference implementation
// MakeCode JavaScript for Minecraft Education Edition
// ============================================================
//
// PURPOSE:
//   This is a fully working example for teachers to reference
//   or for advanced students to study. It demonstrates all
//   four bug fixes from the lesson working together correctly:
//
//   ✅ Bug 1 fix: score variable at top-level scope
//   ✅ Bug 2 fix: correct block type in event handler
//   ✅ Bug 3 fix: valid command syntax (no typos)
//   ✅ Bug 4 fix: relative spawn positions, valid mob types
//
// HOW TO PLAY:
//   - Collect diamonds by stepping on GOLD blocks (the pads)
//   - Avoid zombies that spawn every 30 seconds
//   - Reach 10 points to win!
//
// WORLD SETUP:
//   1. Create a flat area (10x10 minimum)
//   2. Place 5–8 gold blocks scattered around as "pads"
//   3. Make sure the area is well-lit (no natural mob spawning)
//   4. Copy this code into the MakeCode editor
// ============================================================


// ─── TOP-LEVEL VARIABLES (Bug 1 lesson: scope matters) ───────────────────────
let playerScore = 0;    // persists for the whole game
let waveCount   = 0;    // tracks how many zombie waves have spawned
let gameActive  = true; // prevents scoring after game ends
const WIN_SCORE = 10;   // target score to win


// ─── CHECKPOINT / SCORING (Bug 2 lesson: correct block type) ─────────────────
player.onTravelled(TravelMethod.Walk, function () {
    if (!gameActive) { return; }
    
    // say("DEBUG: walk event fired")  ← uncomment to verify event is working
    
    // ✅ Listening for GOLD BLOCK — must match what's placed in the world
    if (player.isOnBlock(blocks.gold_block)) {
        playerScore = playerScore + 1;
        player.say("💎 +" + 1 + "  |  Score: " + playerScore + " / " + WIN_SCORE);
        
        checkWinCondition();
    }
});


// ─── WIN CONDITION ────────────────────────────────────────────────────────────
function checkWinCondition() {
    if (playerScore >= WIN_SCORE) {
        gameActive = false;
        
        // ✅ Valid command syntax (Bug 3 lesson: no typos)
        player.executeCommand("title @a title {\"rawtext\":[{\"text\":\"§a🏆 YOU WIN!\"}]}");
        player.executeCommand("title @a subtitle {\"rawtext\":[{\"text\":\"Score: " + playerScore + "\"}]}");
        player.executeCommand("give @p emerald 5");   // reward
        
        player.say("🎉 Congratulations! Final score: " + playerScore);
    }
}


// ─── MOB SPAWNER (Bug 4 lesson: relative positions, valid mob types) ──────────
loops.everyInterval(30000, function () {  // 30 seconds
    if (!gameActive) { return; }
    
    waveCount = waveCount + 1;
    player.say("⚠️ Wave " + waveCount + "! Zombies incoming!");
    
    // ✅ Spawn RELATIVE to player, y+1 = safely above ground
    spawnMobNearPlayer(MobType.Zombie,   3,  0);
    spawnMobNearPlayer(MobType.Zombie,  -3,  0);
    spawnMobNearPlayer(MobType.Skeleton, 0,  3);
    
    // Difficulty ramp: harder waves after wave 2
    if (waveCount >= 2) {
        spawnMobNearPlayer(MobType.Spider, 0, -3);
    }
    if (waveCount >= 4) {
        spawnMobNearPlayer(MobType.Creeper, 4, 4);
        player.say("💀 Warning: creeper in this wave!");
    }
});


// ─── HELPER FUNCTION ─────────────────────────────────────────────────────────
function spawnMobNearPlayer(mobType, xOffset, zOffset) {
    // y = 1 puts mobs one block ABOVE the ground — never underground
    let spawnPos = positions.add(
        player.position(),
        world(xOffset, 1, zOffset)
    );
    mobs.spawn(mobType, spawnPos);
}


// ─── GAME SETUP (runs once when world loads) ──────────────────────────────────
player.onChat("start", function () {
    playerScore = 0;
    waveCount   = 0;
    gameActive  = true;
    player.say("🎮 Diamond Rush started! Reach " + WIN_SCORE + " points to win!");
    player.say("Step on GOLD BLOCKS to score. Avoid the zombies!");
});

player.onChat("score", function () {
    player.say("Current score: " + playerScore + " / " + WIN_SCORE);
});

player.onChat("reset", function () {
    playerScore = 0;
    waveCount   = 0;
    gameActive  = true;
    player.say("♻️ Game reset! Type 'start' to play again.");
});
