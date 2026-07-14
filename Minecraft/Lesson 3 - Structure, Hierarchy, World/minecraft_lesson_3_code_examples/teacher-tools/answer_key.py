#!/usr/bin/env python3
"""
STEM through Games — Day 3: Structure, Hierarchy & the World
FILE: teacher-tools/answer_key.py

PURPOSE:
    Generates printable answer keys and quiz variations for
    the lesson's math challenge questions.

    - Produces the worked solutions for the 5 challenge questions
    - Generates random variations so different students/groups
      get different numbers (but the same concept)
    - Prints a clean answer key teachers can keep

HOW TO RUN:
    python answer_key.py              → standard answer key
    python answer_key.py --random     → randomized variation
    python answer_key.py --quiz 3     → generate a 3-question quiz sheet
"""

import argparse
import random
from dataclasses import dataclass


@dataclass
class Vec3:
    x: int
    y: int
    z: int

    def __add__(self, other):
        return Vec3(self.x + other.x, self.y + other.y, self.z + other.z)

    def __str__(self):
        return f"({self.x}, {self.y}, {self.z})"


# ─────────────────────────────────────────────────────────────
# Standard challenge questions (from the lesson plan)
# ─────────────────────────────────────────────────────────────

STANDARD_CHALLENGES = [
    {
        "id": 1,
        "title": "Basic: One level of offset",
        "given": {
            "Player House world pos": Vec3(-8, 66, -8),
            "Chest Room local offset": Vec3(1, 1, 1),
        },
        "find": "Chest Room world position",
        "solve": lambda: Vec3(-8, 66, -8) + Vec3(1, 1, 1),
        "worked": [
            "world_pos = parent_pos + local_offset",
            "= (-8 + 1,  66 + 1,  -8 + 1)",
            "= (-7, 67, -7)",
        ],
    },
    {
        "id": 2,
        "title": "Parent moves: children follow",
        "given": {
            "Player House ORIGINAL world pos": Vec3(-8, 66, -8),
            "Movement (east)": Vec3(100, 0, 0),
            "Chest Room local offset": Vec3(1, 1, 1),
        },
        "find": "Chest Room NEW world position after house moves",
        "solve": lambda: Vec3(-8, 66, -8) + Vec3(100, 0, 0) + Vec3(1, 1, 1),
        "worked": [
            "Step 1: New house pos = old_pos + movement",
            "       = (-8+100, 66+0, -8+0) = (92, 66, -8)",
            "Step 2: world_pos = new_parent_pos + local_offset",
            "       = (92+1, 66+1, -8+1) = (93, 67, -7)",
        ],
    },
    {
        "id": 3,
        "title": "Different axis: Y offset (height)",
        "given": {
            "Player House world pos": Vec3(-8, 66, -8),
            "NameTag Sign local offset": Vec3(0, 2, 0),
        },
        "find": "NameTag Sign world position",
        "solve": lambda: Vec3(-8, 66, -8) + Vec3(0, 2, 0),
        "worked": [
            "world_pos = parent_pos + local_offset",
            "= (-8+0, 66+2, -8+0)",
            "= (-8, 68, -8)",
        ],
    },
    {
        "id": 4,
        "title": "Extension: Chained three-level offset",
        "given": {
            "Outer Wall world pos": Vec3(-10, 66, -10),
            "Player House local offset from wall": Vec3(2, 0, 2),
            "Chest Room local offset from house": Vec3(1, 1, 1),
        },
        "find": "Chest Room world position (chain all offsets)",
        "solve": lambda: Vec3(-10, 66, -10) + Vec3(2, 0, 2) + Vec3(1, 1, 1),
        "worked": [
            "Step 1: Player House world pos = Wall + house_offset",
            "       = (-10+2, 66+0, -10+2) = (-8, 66, -8)",
            "Step 2: Chest Room world pos = House + chest_offset",
            "       = (-8+1, 66+1, -8+1) = (-7, 67, -7)",
            "OR: chain all at once: (-10+2+1, 66+0+1, -10+2+1) = (-7, 67, -7)",
        ],
    },
    {
        "id": 5,
        "title": "Extension: Z-axis shift propagates through tree",
        "given": {
            "Enemy Fortress world pos": Vec3(2, 66, -8),
            "Enemy Chest local offset": Vec3(1, 1, 1),
            "Outer Wall shift (south)": Vec3(0, 0, 50),
        },
        "find": "Enemy Chest world position after wall shifts south",
        "solve": lambda: Vec3(2, 66, -8) + Vec3(0, 0, 50) + Vec3(1, 1, 1),
        "worked": [
            "Step 1: New Fortress pos = old_pos + wall_shift",
            "       = (2+0, 66+0, -8+50) = (2, 66, 42)",
            "Step 2: New Chest pos = new_fortress + chest_offset",
            "       = (2+1, 66+1, 42+1) = (3, 67, 43)",
        ],
    },
]


# ─────────────────────────────────────────────────────────────
# Display helpers
# ─────────────────────────────────────────────────────────────

LINE = "─" * 62


def print_answer_key(challenges):
    print("\n" + "=" * 62)
    print("  STEM through Games — Day 3")
    print("  Math Connection: ANSWER KEY")
    print("  Topic: world_pos = parent_pos + local_offset")
    print("=" * 62 + "\n")

    for ch in challenges:
        print(f"CHALLENGE {ch['id']}: {ch['title']}")
        print(LINE)
        print("  Given:")
        for label, val in ch["given"].items():
            print(f"    {label:40s} {val}")
        print(f"\n  Find: {ch['find']}")
        print("\n  Solution:")
        for step in ch["worked"]:
            print(f"    {step}")
        answer = ch["solve"]()
        print(f"\n  ✓ ANSWER: {answer}")
        print()


# ─────────────────────────────────────────────────────────────
# Random variation generator
# ─────────────────────────────────────────────────────────────

def make_random_variation(seed: int = None):
    """
    Generate a randomized version of the 5 challenges.
    Same concepts, different numbers — useful for assessments.
    """
    if seed is not None:
        random.seed(seed)

    # Random parent position (keep it reasonable for a Minecraft world)
    px = random.randint(-50, 50)
    py = 64
    pz = random.randint(-50, 50)

    # Random local offsets (small positive values)
    ox1 = random.randint(1, 8)
    oy1 = random.randint(0, 4)
    oz1 = random.randint(1, 8)

    ox2 = random.randint(0, 4)
    oy2 = random.randint(1, 3)
    oz2 = random.randint(0, 4)

    # Random movement for Challenge 2
    move_x = random.choice([50, 75, 100, 150]) * random.choice([-1, 1])
    move_z = random.choice([0, 25, 50])

    parent = Vec3(px, py, pz)
    child_offset = Vec3(ox1, oy1, oz1)
    grandchild_offset = Vec3(ox2, oy2, oz2)
    movement = Vec3(move_x, 0, move_z)

    variations = [
        {
            "id": 1,
            "title": "Basic: One level of offset",
            "given": {
                "Player House world pos": parent,
                "Chest Room local offset": child_offset,
            },
            "find": "Chest Room world position",
            "solve": lambda p=parent, c=child_offset: p + c,
            "worked": [
                "world_pos = parent_pos + local_offset",
                f"= ({parent.x}+{child_offset.x}, {parent.y}+{child_offset.y}, {parent.z}+{child_offset.z})",
                f"= {parent + child_offset}",
            ],
        },
        {
            "id": 2,
            "title": "Parent moves: children follow",
            "given": {
                "Player House ORIGINAL world pos": parent,
                "Movement": movement,
                "Chest Room local offset": child_offset,
            },
            "find": "Chest Room NEW world position after house moves",
            "solve": lambda p=parent, m=movement, c=child_offset: p + m + c,
            "worked": [
                f"New house pos = {parent} + {movement} = {parent + movement}",
                f"Chest pos = {parent + movement} + {child_offset} = {parent + movement + child_offset}",
            ],
        },
        {
            "id": 3,
            "title": "Y-axis offset (height)",
            "given": {
                "Player House world pos": parent,
                f"Sign local offset (height only)": Vec3(0, oy2 + 1, 0),
            },
            "find": "Sign world position",
            "solve": lambda p=parent, o=Vec3(0, oy2 + 1, 0): p + o,
            "worked": [
                f"= ({parent.x}+0, {parent.y}+{oy2+1}, {parent.z}+0)",
                f"= {parent + Vec3(0, oy2+1, 0)}",
            ],
        },
        {
            "id": 4,
            "title": "Extension: Three-level chain",
            "given": {
                "Outer Wall world pos": Vec3(px - 2, py, pz - 2),
                "Player House local offset from wall": Vec3(2, 0, 2),
                "Chest Room local offset from house": child_offset,
            },
            "find": "Chest Room world position (chain all offsets)",
            "solve": lambda: Vec3(px - 2, py, pz - 2) + Vec3(2, 0, 2) + child_offset,
            "worked": [
                f"House pos = {Vec3(px-2, py, pz-2)} + (2,0,2) = {parent}",
                f"Chest pos = {parent} + {child_offset} = {parent + child_offset}",
            ],
        },
        {
            "id": 5,
            "title": "Extension: Shift propagates through tree",
            "given": {
                "Enemy Fortress world pos": Vec3(px + 10, py, pz),
                "Enemy Chest local offset": grandchild_offset,
                "World shift (all structures move)": Vec3(0, 0, move_z if move_z != 0 else 30),
            },
            "find": "Enemy Chest world position after world shifts",
            "solve": lambda: Vec3(px+10, py, pz) + Vec3(0, 0, move_z if move_z != 0 else 30) + grandchild_offset,
            "worked": [
                f"New fortress = {Vec3(px+10, py, pz)} + {Vec3(0, 0, move_z if move_z != 0 else 30)} = {Vec3(px+10, py, pz) + Vec3(0, 0, move_z if move_z != 0 else 30)}",
                f"Chest = ... + {grandchild_offset} = {Vec3(px+10, py, pz) + Vec3(0, 0, move_z if move_z != 0 else 30) + grandchild_offset}",
            ],
        },
    ]

    return variations


# ─────────────────────────────────────────────────────────────
# Quiz sheet (student-facing, no answers)
# ─────────────────────────────────────────────────────────────

def print_quiz_sheet(challenges, n: int):
    selected = challenges[:n]

    print("\n" + "=" * 62)
    print("  STEM through Games — Day 3")
    print("  Math Connection Quiz")
    print(f"  Name: _______________________   Date: ___________")
    print("=" * 62 + "\n")
    print("  Formula:  world_pos = parent_pos + local_offset\n")

    for ch in selected:
        print(f"Question {ch['id']}: {ch['title']}")
        print(LINE)
        print("  Given:")
        for label, val in ch["given"].items():
            print(f"    {label:40s} {val}")
        print(f"\n  Find: {ch['find']}")
        print("\n  Show your work:")
        print()
        print("  " + " " * 50)
        print("  " + " " * 50)
        print()
        answer = ch["solve"]()
        print(f"  Answer: _______________")
        print()


# ─────────────────────────────────────────────────────────────
# Main
# ─────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(description="STEM Day 3 Answer Key Generator")
    parser.add_argument("--random", action="store_true", help="Generate random variation")
    parser.add_argument("--seed", type=int, default=None, help="Random seed for reproducibility")
    parser.add_argument("--quiz", type=int, default=None, metavar="N", help="Print N-question student quiz (no answers)")
    args = parser.parse_args()

    if args.random:
        seed = args.seed or random.randint(1000, 9999)
        print(f"\n[Random variation — seed: {seed}]")
        challenges = make_random_variation(seed)
    else:
        challenges = STANDARD_CHALLENGES

    if args.quiz:
        print_quiz_sheet(challenges, args.quiz)
    else:
        print_answer_key(challenges)


if __name__ == "__main__":
    main()
