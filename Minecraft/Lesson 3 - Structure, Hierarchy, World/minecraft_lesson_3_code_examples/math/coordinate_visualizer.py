#!/usr/bin/env python3
"""
STEM through Games — Day 3: Structure, Hierarchy & the World
FILE: math/coordinate_visualizer.py

PURPOSE:
    An interactive command-line tool that teaches the math behind
    parent-child coordinates. Mirrors the Math Connection section
    of the lesson plan exactly.

    No Minecraft needed — run this on any computer with Python 3.
    Great for the math segment, a flipped classroom activity,
    or early finishers.

CONCEPTS COVERED:
    - Absolute world coordinates (X, Y, Z)
    - Local offsets (child position relative to parent)
    - The formula: world_pos = parent_pos + local_offset
    - Chained offsets across multiple hierarchy levels
    - The challenge questions from the lesson plan

HOW TO RUN:
    python coordinate_visualizer.py

REQUIREMENTS:
    Python 3.7+  (no external libraries needed)
"""

# ─────────────────────────────────────────────────────────────
# Data structures
# ─────────────────────────────────────────────────────────────

from dataclasses import dataclass, field
from typing import Optional, List


@dataclass
class Vec3:
    """A 3D coordinate or offset (X, Y, Z)."""
    x: float
    y: float
    z: float

    def __add__(self, other: "Vec3") -> "Vec3":
        """Add two vectors: world_pos = parent_pos + local_offset"""
        return Vec3(self.x + other.x, self.y + other.y, self.z + other.z)

    def __sub__(self, other: "Vec3") -> "Vec3":
        """Subtract: local_offset = child_world_pos - parent_world_pos"""
        return Vec3(self.x - other.x, self.y - other.y, self.z - other.z)

    def __str__(self) -> str:
        return f"(X:{self.x:>6.1f},  Y:{self.y:>6.1f},  Z:{self.z:>6.1f})"

    def __repr__(self) -> str:
        return self.__str__()


@dataclass
class StructureNode:
    """
    Represents one structure in the compound hierarchy.
    Mirrors the lesson plan table exactly.
    """
    name: str
    structure_type: str
    parent_name: Optional[str]     # None = root node
    local_offset: Vec3             # offset from parent's origin
    world_pos: Optional[Vec3] = None   # calculated at runtime


# ─────────────────────────────────────────────────────────────
# The compound hierarchy from the lesson plan
# ─────────────────────────────────────────────────────────────

HIERARCHY: List[StructureNode] = [
    StructureNode(
        name="Outer Wall",
        structure_type="Root / World Container",
        parent_name=None,
        local_offset=Vec3(0, 0, 0),
        world_pos=Vec3(-10, 66, -10),     # absolute world position of the root
    ),
    StructureNode(
        name="Player House",
        structure_type="Main Building (oak planks)",
        parent_name="Outer Wall",
        local_offset=Vec3(2, 0, 2),
    ),
    StructureNode(
        name="Chest Room",
        structure_type="Interior storage (child of Player House)",
        parent_name="Player House",
        local_offset=Vec3(1, 1, 1),
    ),
    StructureNode(
        name="NameTag Sign",
        structure_type="Door sign (child of Player House)",
        parent_name="Player House",
        local_offset=Vec3(0, 2, 0),
    ),
    StructureNode(
        name="Enemy Fortress",
        structure_type="Stone brick structure",
        parent_name="Outer Wall",
        local_offset=Vec3(12, 0, 2),
    ),
    StructureNode(
        name="Enemy Chest",
        structure_type="Interior chest (child of Fortress)",
        parent_name="Enemy Fortress",
        local_offset=Vec3(1, 1, 1),
    ),
    StructureNode(
        name="Ground Plane",
        structure_type="Bedrock / dirt layer",
        parent_name="Outer Wall",
        local_offset=Vec3(0, -1, 0),
    ),
]


# ─────────────────────────────────────────────────────────────
# Core functions
# ─────────────────────────────────────────────────────────────

def build_world_positions(hierarchy: List[StructureNode]) -> dict:
    """
    Calculate the absolute world position for every node
    by walking the tree and applying:
        world_pos = parent_world_pos + local_offset

    Returns a dict: { node_name: Vec3(world_pos) }
    """
    world_pos_map = {}

    # Root node already has world_pos set
    root = next(n for n in hierarchy if n.parent_name is None)
    world_pos_map[root.name] = root.world_pos

    # Iteratively resolve children (handles any depth)
    unresolved = [n for n in hierarchy if n.parent_name is not None]
    max_passes = len(hierarchy)

    while unresolved and max_passes > 0:
        still_unresolved = []
        for node in unresolved:
            if node.parent_name in world_pos_map:
                parent_pos = world_pos_map[node.parent_name]
                world_pos_map[node.name] = parent_pos + node.local_offset
                node.world_pos = world_pos_map[node.name]
            else:
                still_unresolved.append(node)
        unresolved = still_unresolved
        max_passes -= 1

    return world_pos_map


def get_node(name: str) -> Optional[StructureNode]:
    """Find a node by name (case-insensitive)."""
    return next(
        (n for n in HIERARCHY if n.name.lower() == name.lower()), None
    )


def get_children(parent_name: str) -> List[StructureNode]:
    """Return all direct children of a node."""
    return [n for n in HIERARCHY if n.parent_name == parent_name]


def get_all_descendants(name: str) -> List[StructureNode]:
    """Return all descendants (children, grandchildren, etc.)."""
    result = []
    for child in get_children(name):
        result.append(child)
        result.extend(get_all_descendants(child.name))
    return result


# ─────────────────────────────────────────────────────────────
# Display functions
# ─────────────────────────────────────────────────────────────

GREEN  = "\033[32m"
CYAN   = "\033[36m"
YELLOW = "\033[33m"
BOLD   = "\033[1m"
RESET  = "\033[0m"
DIM    = "\033[2m"


def print_header(title: str):
    width = 60
    print(f"\n{BOLD}{GREEN}{'=' * width}{RESET}")
    print(f"{BOLD}{GREEN}  {title}{RESET}")
    print(f"{BOLD}{GREEN}{'=' * width}{RESET}\n")


def print_hierarchy(world_pos_map: dict, node_name: str = None, indent: int = 0):
    """Print the hierarchy as an indented tree."""
    if node_name is None:
        # Start from root
        root = next(n for n in HIERARCHY if n.parent_name is None)
        node_name = root.name

    node = get_node(node_name)
    if not node:
        return

    prefix = "  " * indent + ("└─ " if indent > 0 else "")
    world_pos = world_pos_map.get(node_name)

    print(f"{BOLD}{prefix}{node.name}{RESET}  {DIM}({node.structure_type}){RESET}")
    print(f"{"  " * (indent + 1)}  World position : {CYAN}{world_pos}{RESET}")
    if node.parent_name:
        print(f"{"  " * (indent + 1)}  Local offset   : {YELLOW}{node.local_offset}{RESET}  from {node.parent_name}")
    print()

    for child in get_children(node_name):
        print_hierarchy(world_pos_map, child.name, indent + 1)


def show_math_for_node(node_name: str, world_pos_map: dict):
    """Show the step-by-step math for one node."""
    node = get_node(node_name)
    if not node:
        print(f"Structure '{node_name}' not found.")
        return

    print_header(f"MATH: {node.name}")

    if node.parent_name is None:
        print("This is the ROOT node — it has no parent.")
        print(f"World position (given): {CYAN}{world_pos_map[node.name]}{RESET}")
        return

    parent_pos = world_pos_map[node.parent_name]
    local = node.local_offset
    world  = world_pos_map[node.name]

    print(f"  Parent:           {node.parent_name}")
    print(f"  Parent world pos: {CYAN}{parent_pos}{RESET}")
    print(f"  Local offset:     {YELLOW}{local}{RESET}")
    print()
    print(f"  Formula:  world_pos  =  parent_pos + local_offset")
    print()
    print(f"  X:  {parent_pos.x:>6.1f}  +  {local.x:>5.1f}  =  {BOLD}{world.x:>6.1f}{RESET}")
    print(f"  Y:  {parent_pos.y:>6.1f}  +  {local.y:>5.1f}  =  {BOLD}{world.y:>6.1f}{RESET}")
    print(f"  Z:  {parent_pos.z:>6.1f}  +  {local.z:>5.1f}  =  {BOLD}{world.z:>6.1f}{RESET}")
    print()
    print(f"  World position = {CYAN}{BOLD}{world}{RESET}")


# ─────────────────────────────────────────────────────────────
# Lesson Plan Challenge Questions (interactive)
# ─────────────────────────────────────────────────────────────

def run_challenge(number: int, world_pos_map: dict):
    """Run one of the lesson plan's math challenge questions."""

    challenges = {
        1: {
            "question": (
                "Player House is at world position (-8, 66, -8).\n"
                "The Chest Room is at local offset (1, 1, 1) from the house.\n"
                "What is the Chest Room's WORLD position?"
            ),
            "work": lambda: (
                Vec3(-8, 66, -8),
                Vec3(1, 1, 1),
                Vec3(-8, 66, -8) + Vec3(1, 1, 1),
            ),
        },
        2: {
            "question": (
                "Player House moves 100 blocks east (X + 100).\n"
                "New house position = (-8+100, 66, -8) = (92, 66, -8).\n"
                "What is the NEW world position of the Chest Room?"
            ),
            "work": lambda: (
                Vec3(92, 66, -8),
                Vec3(1, 1, 1),
                Vec3(92, 66, -8) + Vec3(1, 1, 1),
            ),
        },
        3: {
            "question": (
                "The NameTag Sign is at local offset (0, 2, 0) from Player House.\n"
                "Player House is at world position (-8, 66, -8).\n"
                "What is the sign's world position?"
            ),
            "work": lambda: (
                Vec3(-8, 66, -8),
                Vec3(0, 2, 0),
                Vec3(-8, 66, -8) + Vec3(0, 2, 0),
            ),
        },
        4: {
            "question": (
                "EXTENSION — Three-level chain:\n"
                "Outer Wall corner = (-10, 66, -10)\n"
                "Player House local offset from wall = (2, 0, 2)\n"
                "Chest Room local offset from house  = (1, 1, 1)\n"
                "What is the Chest Room's world position?\n"
                "(Add ALL offsets in the chain.)"
            ),
            "work": lambda: (
                Vec3(-10, 66, -10) + Vec3(2, 0, 2),
                Vec3(1, 1, 1),
                Vec3(-10, 66, -10) + Vec3(2, 0, 2) + Vec3(1, 1, 1),
            ),
        },
        5: {
            "question": (
                "Enemy Fortress world pos = (2, 66, -8).\n"
                "Enemy Chest local offset = (1, 1, 1).\n"
                "The Outer Wall shifts Z + 50, moving everything with it.\n"
                "What is the FINAL world position of the Enemy Chest?"
            ),
            "work": lambda: (
                Vec3(2, 66, -8) + Vec3(0, 0, 50),
                Vec3(1, 1, 1),
                Vec3(2, 66, -8) + Vec3(0, 0, 50) + Vec3(1, 1, 1),
            ),
        },
    }

    if number not in challenges:
        print(f"Challenge {number} not found. Available: 1–5")
        return

    ch = challenges[number]
    print_header(f"CHALLENGE {number}")
    print(ch["question"])
    print()
    input(f"{DIM}  Press ENTER to see the answer...{RESET}")
    print()

    parent_pos, local, world = ch["work"]()
    print(f"  Parent / intermediate pos: {CYAN}{parent_pos}{RESET}")
    print(f"  Local offset:              {YELLOW}{local}{RESET}")
    print(f"  Formula: world = parent + offset")
    print(f"  Answer:  {BOLD}{CYAN}{world}{RESET}")
    print()


# ─────────────────────────────────────────────────────────────
# Move simulation
# ─────────────────────────────────────────────────────────────

def simulate_move(structure_name: str, movement: Vec3, world_pos_map: dict):
    """
    Simulate moving a parent structure and show where all
    its children end up. Mirrors the lesson's teleport demo.
    """
    node = get_node(structure_name)
    if not node:
        print(f"Structure '{structure_name}' not found.")
        return

    old_pos = world_pos_map.get(structure_name)
    new_pos = old_pos + movement

    print_header(f"MOVE SIMULATION: {structure_name}")
    print(f"  Moving by:     {YELLOW}{movement}{RESET}")
    print(f"  Old position:  {old_pos}")
    print(f"  New position:  {BOLD}{CYAN}{new_pos}{RESET}")
    print()

    descendants = get_all_descendants(structure_name)
    if descendants:
        print(f"  Children that move with {structure_name}:")
        for desc in descendants:
            old = world_pos_map[desc.name]
            new = old + movement
            print(f"    {desc.name}")
            print(f"      {old}  →  {BOLD}{CYAN}{new}{RESET}")
        print()
        print("  KEY INSIGHT: every child shifts by the SAME amount as the parent.")
        print("  The local offsets stay the same — only the world positions change.")
    else:
        print("  (this structure has no children)")


# ─────────────────────────────────────────────────────────────
# Main interactive menu
# ─────────────────────────────────────────────────────────────

def main():
    # Build world positions once at startup
    world_pos_map = build_world_positions(HIERARCHY)

    print_header("STEM Day 3: Coordinate Visualizer")
    print("  This tool demonstrates the math behind parent-child coordinates.")
    print("  It mirrors the Math Connection section of today's lesson.\n")

    while True:
        print(f"\n{BOLD}What would you like to do?{RESET}")
        print("  1  Show the full compound hierarchy")
        print("  2  Show math for a specific structure")
        print("  3  Run a lesson challenge question (1–5)")
        print("  4  Simulate moving a structure")
        print("  5  Calculate: enter any parent pos + offset")
        print("  q  Quit")
        print()
        choice = input("Enter choice: ").strip().lower()

        if choice == "1":
            print_header("COMPOUND HIERARCHY")
            print_hierarchy(world_pos_map)

        elif choice == "2":
            names = [n.name for n in HIERARCHY]
            print("\nAvailable structures:")
            for name in names:
                print(f"  • {name}")
            name = input("\nEnter structure name: ").strip()
            show_math_for_node(name, world_pos_map)

        elif choice == "3":
            try:
                n = int(input("Challenge number (1–5): ").strip())
                run_challenge(n, world_pos_map)
            except ValueError:
                print("Please enter a number 1–5.")

        elif choice == "4":
            names = [n.name for n in HIERARCHY]
            print("\nAvailable structures:")
            for name in names:
                print(f"  • {name}")
            name = input("\nStructure to move: ").strip()
            try:
                dx = float(input("  Move X by: "))
                dy = float(input("  Move Y by: "))
                dz = float(input("  Move Z by: "))
                simulate_move(name, Vec3(dx, dy, dz), world_pos_map)
            except ValueError:
                print("Please enter valid numbers.")

        elif choice == "5":
            print("\nEnter a parent position and local offset to calculate world position.")
            try:
                px = float(input("  Parent X: "))
                py = float(input("  Parent Y: "))
                pz = float(input("  Parent Z: "))
                ox = float(input("  Offset X: "))
                oy = float(input("  Offset Y: "))
                oz = float(input("  Offset Z: "))
                parent = Vec3(px, py, pz)
                offset = Vec3(ox, oy, oz)
                world  = parent + offset
                print()
                print(f"  Parent position:  {CYAN}{parent}{RESET}")
                print(f"  Local offset:     {YELLOW}{offset}{RESET}")
                print(f"  World position:   {BOLD}{CYAN}{world}{RESET}")
                print(f"  Formula: ({px}+{ox}, {py}+{oy}, {pz}+{oz}) = ({world.x}, {world.y}, {world.z})")
            except ValueError:
                print("Please enter valid numbers.")

        elif choice == "q":
            print("\nGood work today! Remember: world_pos = parent_pos + local_offset\n")
            break

        else:
            print("Invalid choice. Please enter 1–5 or q.")


if __name__ == "__main__":
    main()
