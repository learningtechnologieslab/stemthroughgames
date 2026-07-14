#!/usr/bin/env python3
"""
================================================================
 EXAMPLE 4 — Minecraft Distance Calculator
 Lesson: Day 2 — Spatial Thinking & 3D Coordinates (Enrichment)
 Language: Python 3  (run in any Python environment)
================================================================

 WHAT THIS DOES
 --------------
 Calculates the straight-line (Euclidean) distance between any
 two Minecraft coordinates using the 3D distance formula:

   d = sqrt( (x2-x1)^2 + (y2-y1)^2 + (z2-z1)^2 )

 This is the same formula from math class — just extended to 3D
 by adding the Z term.

 HOW TO RUN
 ----------
 Option A — Interactive mode (default):
   python distance_calculator.py

 Option B — Edit the PRESET LOCATIONS list below and run:
   python distance_calculator.py --presets

 Option C — Pass coordinates directly:
   python distance_calculator.py 0 64 0 100 64 200

================================================================
"""

import math
import sys


# ---- Core Formula ------------------------------------------------

def distance_3d(x1, y1, z1, x2, y2, z2):
    """
    Returns the straight-line distance between two 3D points.
    Formula: sqrt( (x2-x1)^2 + (y2-y1)^2 + (z2-z1)^2 )
    """
    return math.sqrt((x2 - x1)**2 + (y2 - y1)**2 + (z2 - z1)**2)


def distance_2d_horizontal(x1, z1, x2, z2):
    """
    Returns the flat (horizontal-only) distance, ignoring elevation.
    Useful for map distances where you don't care about hills.
    Formula: sqrt( (x2-x1)^2 + (z2-z1)^2 )
    """
    return math.sqrt((x2 - x1)**2 + (z2 - z1)**2)


# ---- Display Helper ----------------------------------------------

def print_result(name_a, name_b, x1, y1, z1, x2, y2, z2):
    """Prints a full breakdown of the distance calculation."""
    d3 = distance_3d(x1, y1, z1, x2, y2, z2)
    d2 = distance_2d_horizontal(x1, z1, x2, z2)

    print()
    print("=" * 55)
    print(f"  From: {name_a}  ({x1}, {y1}, {z1})")
    print(f"  To:   {name_b}  ({x2}, {y2}, {z2})")
    print("-" * 55)

    # Show the formula with numbers filled in
    dx = x2 - x1
    dy = y2 - y1
    dz = z2 - z1
    print(f"  Step 1 — Differences:")
    print(f"    ΔX = {x2} - {x1} = {dx}")
    print(f"    ΔY = {y2} - {y1} = {dy}")
    print(f"    ΔZ = {z2} - {z1} = {dz}")
    print()
    print(f"  Step 2 — Square each difference:")
    print(f"    ΔX² = {dx}² = {dx**2}")
    print(f"    ΔY² = {dy}² = {dy**2}")
    print(f"    ΔZ² = {dz}² = {dz**2}")
    print()
    print(f"  Step 3 — Add and take the square root:")
    total = dx**2 + dy**2 + dz**2
    print(f"    √({dx**2} + {dy**2} + {dz**2}) = √{total}")
    print()
    print(f"  ✅ Straight-line distance:  {d3:.2f} blocks")
    print(f"  🗺  Horizontal distance:    {d2:.2f} blocks  (ignoring elevation)")
    print("=" * 55)


# ---- Preset Locations (from the lesson plan) ---------------------

PRESETS = [
    # (name_a, x1, y1, z1,  name_b, x2, y2, z2)
    ("World Origin",     0,   64,  0,
     "100 Blocks East",  100, 64,  0),

    ("Village A",        100, 64,  200,
     "Village B",        100, 64,  500),

    ("Surface",          0,   64,  0,
     "Underground",      0,   20,  0),

    ("Scavenger Start",  0,   64,  0,
     "Hidden Chest",     50,  64,  -50),

    ("Spawn",            0,   64,  0,
     "Sky Limit",        0,   255, 0),
]


def run_presets():
    """Runs all preset distance calculations from the lesson."""
    print("\n🧮  MINECRAFT DISTANCE CALCULATOR — Lesson Presets")
    for name_a, x1, y1, z1, name_b, x2, y2, z2 in PRESETS:
        print_result(name_a, name_b, x1, y1, z1, x2, y2, z2)


# ---- Interactive Mode --------------------------------------------

def run_interactive():
    """Asks the student to enter two coordinates and calculates the distance."""
    print("\n🧮  MINECRAFT DISTANCE CALCULATOR")
    print("  Enter two Minecraft locations to find the distance between them.")
    print("  (Type 'quit' at any time to exit)\n")

    while True:
        print("-" * 40)
        try:
            raw_a = input("  Location A — name (e.g. 'Spawn'): ").strip()
            if raw_a.lower() == "quit":
                break
            coords_a = input("  Location A — X Y Z (e.g. 0 64 0): ").strip()
            if coords_a.lower() == "quit":
                break
            x1, y1, z1 = map(int, coords_a.split())

            raw_b = input("  Location B — name (e.g. 'Village'): ").strip()
            if raw_b.lower() == "quit":
                break
            coords_b = input("  Location B — X Y Z (e.g. 100 64 200): ").strip()
            if coords_b.lower() == "quit":
                break
            x2, y2, z2 = map(int, coords_b.split())

        except ValueError:
            print("  ⚠️  Please enter three whole numbers separated by spaces (e.g. 100 64 200)")
            continue

        print_result(raw_a, raw_b, x1, y1, z1, x2, y2, z2)

        again = input("\n  Calculate another distance? (y/n): ").strip().lower()
        if again != "y":
            break

    print("\n  Thanks for calculating! 📐\n")


# ---- Command-Line Mode -------------------------------------------

def run_from_args(args):
    """Accepts 6 integers from the command line: x1 y1 z1 x2 y2 z2"""
    try:
        x1, y1, z1, x2, y2, z2 = map(int, args)
    except ValueError:
        print("Usage: python distance_calculator.py x1 y1 z1 x2 y2 z2")
        print("Example: python distance_calculator.py 0 64 0 100 64 200")
        sys.exit(1)
    print_result("Point A", "Point B", x1, y1, z1, x2, y2, z2)


# ---- Entry Point -------------------------------------------------

if __name__ == "__main__":
    args = sys.argv[1:]

    if args and args[0] == "--presets":
        run_presets()
    elif len(args) == 6:
        run_from_args(args)
    else:
        run_interactive()
