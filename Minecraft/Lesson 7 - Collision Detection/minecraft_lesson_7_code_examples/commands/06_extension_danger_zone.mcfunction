# ─────────────────────────────────────────────────────────────────────────────
# 06_extension_danger_zone.mcfunction
# STEM Through Games — Day 7: Collision Detection
# ─────────────────────────────────────────────────────────────────────────────
#
# PURPOSE (Extension / Challenge tier)
#   Separate scoreboards for safe zones (coins) vs. dangerous zones.
#   Students build a world where they must navigate toward gold blocks
#   while avoiding lava or TNT zones that add to a "damage" score.
#
#   This shows that the SAME collision detection logic works for both
#   rewarding and punishing interactions — the only difference is which
#   scoreboard objective gets incremented.
#
# PREREQUISITE
#   Run 01_setup_scoreboard.mcfunction first.
#   It creates both the "score" (coins) and "damage" (danger) objectives.
#
# WORLD LAYOUT SUGGESTION
#   Safe Zone  A: gold block  at (11, 64, 11)  — east path
#   Danger Zone: lava pit marker at (21, 64, 11) — center
#   Safe Zone  B: gold block  at (31, 64, 11)  — west path
#   Player must navigate from south to north, collecting coins, avoiding danger.
#
# ─────────────────────────────────────────────────────────────────────────────


# ══════════════════════════════════════════════════════════════
# SAFE ZONE A  (coin — adds to "score")
# ══════════════════════════════════════════════════════════════

# [REPEAT — Unconditional, Always Active]
/testfor @a[x=10,y=64,z=10,dx=3,dy=2,dz=3]

# [CHAIN 1 — Conditional]
/scoreboard players add @a[x=10,y=64,z=10,dx=3,dy=2,dz=3] score 1

# [CHAIN 2 — Conditional]
/fill 11 64 11 11 64 11 barrier

# [CHAIN 3 — Conditional]
/title @a[x=10,y=64,z=10,dx=3,dy=2,dz=3] actionbar "Coin collected! +1 score"


# ══════════════════════════════════════════════════════════════
# DANGER ZONE  (hazard — adds to "damage")
# Visual marker: red_concrete or netherrack at (21, 64, 11)
# Make the zone slightly LARGER than the safe zones to feel more threatening
# ══════════════════════════════════════════════════════════════

# [REPEAT — Unconditional, Always Active]
/testfor @a[x=19,y=64,z=9,dx=5,dy=2,dz=5]

# [CHAIN 1 — Conditional]  increment damage score
/scoreboard players add @a[x=19,y=64,z=9,dx=5,dy=2,dz=5] damage 1

# [CHAIN 2 — Conditional]  apply damage effect to player
/effect @a[x=19,y=64,z=9,dx=5,dy=2,dz=5] poison 1 0

# [CHAIN 3 — Conditional]  warn the player
/title @a[x=19,y=64,z=9,dx=5,dy=2,dz=5] actionbar "DANGER! -1 health"


# ══════════════════════════════════════════════════════════════
# SAFE ZONE B  (coin — adds to "score")
# ══════════════════════════════════════════════════════════════

# [REPEAT — Unconditional, Always Active]
/testfor @a[x=30,y=64,z=10,dx=3,dy=2,dz=3]

# [CHAIN 1 — Conditional]
/scoreboard players add @a[x=30,y=64,z=10,dx=3,dy=2,dz=3] score 1

# [CHAIN 2 — Conditional]
/fill 31 64 11 31 64 11 barrier

# [CHAIN 3 — Conditional]
/title @a[x=30,y=64,z=10,dx=3,dy=2,dz=3] actionbar "Coin collected! +1 score"


# ══════════════════════════════════════════════════════════════
# WIN / LOSE CONDITIONS
# ══════════════════════════════════════════════════════════════

# WIN: collected both coins with no damage
# [REPEAT — Unconditional, Always Active]
/scoreboard players test @a score 2 *

# [CHAIN 1 — Conditional]  only congratulate players with 0 damage
# NOTE: Minecraft Education doesn't support multiple selector conditions
# in one command; use two chain blocks as an approximation.
/title @a title "YOU WIN!"
/title @a subtitle "Both coins collected!"
/playsound random.levelup @a


# ── LOSE: took too much damage ───────────────────────────────────────────────

# [REPEAT — Unconditional, Always Active]
/scoreboard players test @a damage 3 *

# [CHAIN 1 — Conditional]
/title @a title "GAME OVER"
/title @a subtitle "Too much damage taken!"


# ─────────────────────────────────────────────────────────────────────────────
# DISCUSSION QUESTIONS (for the reflection activity)
# ─────────────────────────────────────────────────────────────────────────────
#
# 1. The danger zone has dx=5 (6 blocks wide) vs the safe zone's dx=3 (4 wide).
#    How does this larger hitbox change the feel of the game?
#    What does it communicate to the player?
#
# 2. If you made the danger zone's hitbox SMALLER than the visual marker,
#    what would that feel like? (More forgiving, but visually confusing.)
#    When might that be a good design choice?
#
# 3. Can you redesign the layout so the danger zone is between the two safe
#    zones, forcing the player to choose a route?
#
# ─────────────────────────────────────────────────────────────────────────────
