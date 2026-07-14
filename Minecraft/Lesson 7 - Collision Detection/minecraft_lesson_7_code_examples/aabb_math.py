"""
aabb_math.py
============
STEM Through Games — Day 7: Collision Detection
Minecraft Education Edition

This file demonstrates AABB (Axis-Aligned Bounding Box) collision math
in plain Python. It mirrors the exact logic Minecraft uses internally
when it checks whether a player has entered a /testfor zone.

Run it from a terminal:
    python aabb_math.py

Then try editing the coordinates at the bottom to test your own zones.
"""


# ─────────────────────────────────────────────────────────────
# PART 1: The Zone data structure
# ─────────────────────────────────────────────────────────────

class Zone:
    """
    Represents a rectangular detection zone in Minecraft block space.

    In Minecraft, /testfor uses corner coordinates (x, y, z) plus
    offsets (dx, dy, dz) to define a box.  We store them the same way.

    Args:
        name  : A label so we can tell zones apart in output
        x, y, z       : The corner with the LOWEST coordinates
        dx, dy, dz    : How many extra blocks extend in each direction
                        (dx=3 means the zone spans x, x+1, x+2, x+3 → 4 blocks)
    """

    def __init__(self, name, x, y, z, dx, dy, dz):
        self.name = name
        self.x  = x
        self.y  = y
        self.z  = z
        self.dx = dx
        self.dy = dy
        self.dz = dz

    # Computed edges — the far wall of the box
    @property
    def x_max(self):
        return self.x + self.dx

    @property
    def y_max(self):
        return self.y + self.dy

    @property
    def z_max(self):
        return self.z + self.dz

    def __repr__(self):
        return (
            f"Zone('{self.name}'  "
            f"corner=({self.x},{self.y},{self.z})  "
            f"size={self.dx+1}x{self.dy+1}x{self.dz+1} blocks)"
        )

    def as_testfor_command(self, selector="@a"):
        """Return the Minecraft /testfor command for this zone."""
        return (
            f"/testfor {selector}"
            f"[x={self.x},y={self.y},z={self.z},"
            f"dx={self.dx},dy={self.dy},dz={self.dz}]"
        )


# ─────────────────────────────────────────────────────────────
# PART 2: The AABB overlap check
# ─────────────────────────────────────────────────────────────

def aabb_overlap(zone_a, zone_b):
    """
    Return True if zone_a and zone_b overlap (share at least one block).

    This is the same 4-comparison test Minecraft's physics engine runs
    every tick for every pair of nearby entities.

    Two ranges [a_min, a_max] and [b_min, b_max] overlap when:
        a_min < b_max   AND   b_min < a_max

    We apply that rule to all three axes (X, Y, Z).
    """

    # X axis (East–West)
    x_overlap = (zone_a.x < zone_b.x_max) and (zone_b.x < zone_a.x_max)

    # Y axis (Up–Down)
    y_overlap = (zone_a.y < zone_b.y_max) and (zone_b.y < zone_a.y_max)

    # Z axis (North–South)
    z_overlap = (zone_a.z < zone_b.z_max) and (zone_b.z < zone_a.z_max)

    return x_overlap and y_overlap and z_overlap


def explain_overlap(zone_a, zone_b):
    """
    Print a step-by-step explanation of whether two zones overlap.
    Great for the classroom worked example.
    """
    print("=" * 60)
    print(f"Checking: {zone_a.name}  vs  {zone_b.name}")
    print("=" * 60)

    print(f"\n  {zone_a.name}:")
    print(f"    X range: [{zone_a.x}, {zone_a.x_max}]")
    print(f"    Y range: [{zone_a.y}, {zone_a.y_max}]")
    print(f"    Z range: [{zone_a.z}, {zone_a.z_max}]")

    print(f"\n  {zone_b.name}:")
    print(f"    X range: [{zone_b.x}, {zone_b.x_max}]")
    print(f"    Y range: [{zone_b.y}, {zone_b.y_max}]")
    print(f"    Z range: [{zone_b.z}, {zone_b.z_max}]")

    print()

    axes = [
        ("X (East-West) ", zone_a.x, zone_a.x_max, zone_b.x, zone_b.x_max),
        ("Y (Up-Down)   ", zone_a.y, zone_a.y_max, zone_b.y, zone_b.y_max),
        ("Z (North-South)", zone_a.z, zone_a.z_max, zone_b.z, zone_b.z_max),
    ]

    all_overlap = True
    for label, a_min, a_max, b_min, b_max in axes:
        cond1 = a_min < b_max
        cond2 = b_min < a_max
        overlaps = cond1 and cond2
        mark = "✓ overlap" if overlaps else "✗ no overlap  ← MISS HERE"
        print(f"  {label}: {a_min}<{b_max}? {'yes':3}  AND  {b_min}<{a_max}? {'yes' if cond2 else 'no ':3}  → {mark}")
        if not overlaps:
            all_overlap = False

    print()
    if all_overlap:
        print("  >>> RESULT: COLLISION DETECTED <<<")
    else:
        print("  >>> RESULT: no collision (at least one axis does not overlap)")
    print()


# ─────────────────────────────────────────────────────────────
# PART 3: Player position helper
# ─────────────────────────────────────────────────────────────

def player_in_zone(player_x, player_y, player_z, zone):
    """
    Check whether a player standing at (player_x, player_y, player_z)
    is inside a detection zone.

    A player occupies roughly a 0.6 × 1.8 × 0.6 block hitbox,
    but for /testfor purposes Minecraft checks the player's foot position.
    We model the player as a 1×2×1 block zone for simplicity.
    """
    player_zone = Zone(
        name="Player",
        x=player_x, y=player_y, z=player_z,
        dx=0, dy=1, dz=0   # 1 block wide, 2 blocks tall
    )
    return aabb_overlap(player_zone, zone)


# ─────────────────────────────────────────────────────────────
# PART 4: Scoreboard simulator
# ─────────────────────────────────────────────────────────────

class ScoreboardSimulator:
    """
    Simulates the Minecraft scoreboard so students can see how scores
    accumulate as the player collects coins — without needing a live
    Minecraft world running.
    """

    def __init__(self):
        self.score = 0
        self.collected_zones = set()

    def tick(self, player_x, player_y, player_z, coin_zones):
        """
        Simulate one game tick: check each coin zone and collect if touching.
        Returns list of newly collected zone names.
        """
        newly_collected = []
        for zone in coin_zones:
            if zone.name in self.collected_zones:
                continue   # already picked up
            if player_in_zone(player_x, player_y, player_z, zone):
                self.score += 1
                self.collected_zones.add(zone.name)
                newly_collected.append(zone.name)
        return newly_collected

    def display(self):
        print(f"  [SCOREBOARD]  score = {self.score}")


# ─────────────────────────────────────────────────────────────
# PART 5: Run the examples
# ─────────────────────────────────────────────────────────────

def run_lesson_example():
    """The worked example from the lesson slides."""
    print("\n" + "=" * 60)
    print("  LESSON EXAMPLE — from the Day 7 slides")
    print("=" * 60)

    # Zone A: corner (2,64,3), size 4x3 → X:[2,6], Z:[3,6]
    # Zone B: corner (5,64,4), size 3x2 → X:[5,8], Z:[4,6]
    # These DO collide: X shares [5,6], Z shares [4,6]
    zone_a = Zone("Zone A", x=2, y=64, z=3, dx=4, dy=2, dz=3)
    zone_b = Zone("Zone B", x=5, y=64, z=4, dx=3, dy=2, dz=2)

    explain_overlap(zone_a, zone_b)


def run_no_collision_example():
    """Example where zones clearly do NOT overlap — for the class exercise."""
    print("\n" + "=" * 60)
    print("  CLASS EXERCISE — find which axis misses")
    print("=" * 60)

    zone_a = Zone("Zone A", x=0, y=64, z=0, dx=3, dy=2, dz=3)
    zone_b = Zone("Zone B", x=10, y=64, z=0, dx=3, dy=2, dz=3)

    explain_overlap(zone_a, zone_b)


def run_coin_collection_simulation():
    """
    Simulate a player walking through a world and collecting coins.
    Shows how /testfor + scoreboard would behave in-game.
    """
    print("\n" + "=" * 60)
    print("  COIN COLLECTION SIMULATION")
    print("  (mirrors the Command Block setup from Part 2)")
    print("=" * 60)

    # Three coin zones placed in the world
    coin_zones = [
        Zone("Coin-1", x=10, y=64, z=10, dx=2, dy=2, dz=2),
        Zone("Coin-2", x=20, y=64, z=10, dx=2, dy=2, dz=2),
        Zone("Coin-3", x=30, y=64, z=10, dx=2, dy=2, dz=2),
    ]

    print("\n  Minecraft commands for these zones:")
    for zone in coin_zones:
        print(f"    {zone.as_testfor_command()}")

    print("\n  Simulating player walking east along Z=11, Y=64:")
    print()

    scoreboard = ScoreboardSimulator()

    # Player walks from x=5 to x=35 in steps of 1
    for player_x in range(5, 36):
        collected = scoreboard.tick(player_x, 64, 11, coin_zones)
        if collected:
            for name in collected:
                print(f"  [x={player_x:2d}]  COLLECTED {name}!  /title @a actionbar \"Coin collected!\"")
                scoreboard.display()

    print()
    scoreboard.display()
    print(f"  Zones still uncollected: {[z.name for z in coin_zones if z.name not in scoreboard.collected_zones] or 'none — all collected!'}")


def run_extension_danger_zones():
    """
    Extension activity: separate scoreboards for safe (coins) vs. dangerous zones.
    Mirrors the Challenge tier in the lesson plan.
    """
    print("\n" + "=" * 60)
    print("  EXTENSION — Safe vs. Dangerous Zones")
    print("=" * 60)

    safe_zones = [
        Zone("SafeZone-1", x=5,  y=64, z=5,  dx=2, dy=2, dz=2),
        Zone("SafeZone-2", x=15, y=64, z=5,  dx=2, dy=2, dz=2),
    ]
    danger_zones = [
        Zone("DangerZone-1", x=10, y=64, z=5, dx=2, dy=2, dz=2),
    ]

    print("\n  Safe zone commands (add to 'score' objective):")
    for z in safe_zones:
        print(f"    {z.as_testfor_command()}")

    print("\n  Danger zone commands (add to 'damage' objective):")
    for z in danger_zones:
        print(f"    {z.as_testfor_command()}")

    print()
    print("  Player path: x=3 to x=18, z=6, y=64")
    print()

    score = 0
    damage = 0
    collected_safe = set()
    collected_danger = set()

    for px in range(3, 19):
        for zone in safe_zones:
            if zone.name not in collected_safe and player_in_zone(px, 64, 6, zone):
                score += 1
                collected_safe.add(zone.name)
                print(f"  [x={px:2d}]  SAFE zone hit!    score={score}  /scoreboard players add @a score 1")
        for zone in danger_zones:
            if zone.name not in collected_danger and player_in_zone(px, 64, 6, zone):
                damage += 1
                collected_danger.add(zone.name)
                print(f"  [x={px:2d}]  DANGER zone hit!  damage={damage}  /scoreboard players add @a damage 1")

    print()
    print(f"  Final: score={score}  damage={damage}")


def run_hitbox_size_study():
    """
    Shows how hitbox size affects how forgiving a collision zone feels.
    Connects to the reflection discussion question.
    """
    print("\n" + "=" * 60)
    print("  HITBOX SIZE STUDY — Design Discussion")
    print("  (connects to the exit question: smaller vs. larger hitbox)")
    print("=" * 60)

    # A gold block sitting at position (10, 64, 10)
    # We model two different detection zone sizes around it

    print(f"\n  Gold block marker at (10, 64, 10)")
    print(f"  Player walking east at z=10, y=64 (positions x=8 through x=14)\n")

    player_positions = [(px, 64, 10) for px in range(8, 15)]

    for label, x_offset, dx, dz in [
        ("Tight hitbox  (dx=2, 3 blocks wide — player must step on or adjacent)", 9,  2, 2),
        ("Loose hitbox  (dx=5, 6 blocks wide — player detected from a distance)", 7,  5, 5),
    ]:
        zone = Zone("CoinZone", x=x_offset, y=64, z=9, dx=dx, dy=2, dz=dz)
        detections = [px for (px, py, pz) in player_positions if player_in_zone(px, py, pz, zone)]
        print(f"  {label}")
        print(f"    Zone x range: [{zone.x}, {zone.x_max}]")
        print(f"    Detects player at x positions: {detections}")
        print(f"    {zone.as_testfor_command()}")
        print()


# ─────────────────────────────────────────────────────────────
# MAIN
# ─────────────────────────────────────────────────────────────

if __name__ == "__main__":
    print()
    print("  STEM Through Games — Day 7: Collision Detection")
    print("  AABB Math Examples  |  Minecraft Education Edition")

    run_lesson_example()
    run_no_collision_example()
    run_coin_collection_simulation()
    run_extension_danger_zones()
    run_hitbox_size_study()

    print("\n" + "=" * 60)
    print("  Try editing the coordinates above and re-running!")
    print("  Hint: change Zone B's x to 7 in run_lesson_example()")
    print("        to see what happens when zones barely touch.")
    print("=" * 60)
    print()
