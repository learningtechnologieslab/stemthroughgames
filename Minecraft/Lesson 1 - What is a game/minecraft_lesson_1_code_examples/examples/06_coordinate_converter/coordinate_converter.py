#!/usr/bin/env python3
"""
================================================================
 EXAMPLE 6 — Coordinate System Converter
 Lesson: Day 2 — Spatial Thinking & 3D Coordinates
 Language: Python 3  (run in any Python environment)
================================================================

 WHAT THIS DOES
 --------------
 Helps students understand the relationship between:
   • 2D Math graph paper coordinates  (x, y)
   • Minecraft world coordinates      (X, Y_mc, Z)

 Three conversion modes:

   Mode 1 — Graph Paper  →  Minecraft flat placement
     Maps a 2D math point (x, y) onto the Minecraft
     horizontal plane (sea level).  The math Y becomes the
     Minecraft Z axis since both go "forward" on a flat surface.

   Mode 2 — Minecraft XZ  →  Graph Paper  (reverse of Mode 1)
     Lets students read Minecraft coordinates and write the
     equivalent graph paper point.

   Mode 3 — Batch convert  (the warm-up shape A–E)
     Converts all five warm-up points at once and prints the
     matching /setblock commands.

 HOW TO RUN
 ----------
   python coordinate_converter.py
   python coordinate_converter.py --batch     (warm-up points only)
   python coordinate_converter.py --single 2 3   (one graph point)

================================================================
"""

import sys


# ---- Conversion Logic --------------------------------------------

# Sea-level Y in Minecraft (the elevation at which we place blocks
# when mapping 2D graph points onto the flat world surface)
SEA_LEVEL = 64


def graph_to_minecraft(gx, gy, elevation=SEA_LEVEL):
    """
    Converts a 2D graph paper point (gx, gy) to Minecraft coordinates.

    Mapping:
      Math X  → Minecraft X  (both go East/Right)
      Math Y  → Minecraft Z  (Math "up" = Minecraft "South" on the flat plane)
      Height  → Minecraft Y  (always SEA_LEVEL for flat placement)

    The Y → Z swap is the key concept: in 2D math, Y goes "up" on paper.
    On a flat Minecraft surface, "up on paper" maps to "South" (positive Z).
    This is worth discussing with the class!
    """
    mc_x = gx
    mc_y = elevation
    mc_z = gy
    return mc_x, mc_y, mc_z


def minecraft_to_graph(mc_x, mc_z):
    """
    Converts Minecraft horizontal coordinates back to graph paper.
    Reverse of graph_to_minecraft (ignores elevation/Y).
    """
    gx = mc_x
    gy = mc_z
    return gx, gy


def setblock_command(mc_x, mc_y, mc_z, block="wool"):
    """Returns the /setblock command string for a given coordinate."""
    return f"/setblock {mc_x} {mc_y} {mc_z} {block}"


# ---- Warm-Up Points (from the lesson) ----------------------------

# Each entry: (label, graph_x, graph_y, block_type, colour_name)
WARMUP_POINTS = [
    ("A", 2,  3,  "lime_wool",   "lime"),
    ("B", -1, 4,  "cyan_wool",   "cyan"),
    ("C", -3, -2, "yellow_wool", "yellow"),
    ("D", 4,  -1, "orange_wool", "orange"),
    ("E", 0,  0,  "white_wool",  "white (origin)"),
]


# ---- Display Helpers ---------------------------------------------

def print_header():
    print()
    print("=" * 60)
    print("  COORDINATE CONVERTER  |  Graph Paper  ↔  Minecraft")
    print("=" * 60)


def print_single_conversion(label, gx, gy, block="lime_wool"):
    mc_x, mc_y, mc_z = graph_to_minecraft(gx, gy)
    print()
    print(f"  Point {label}:  Graph ({gx}, {gy})")
    print()
    print(f"    Math X = {gx}  →  Minecraft X = {mc_x}")
    print(f"    Math Y = {gy}  →  Minecraft Z = {mc_z}  (Y on paper = Z in world!)")
    print(f"    Elevation    →  Minecraft Y = {mc_y}  (sea level)")
    print()
    print(f"    Minecraft coordinates:  ({mc_x}, {mc_y}, {mc_z})")
    print(f"    Command:  {setblock_command(mc_x, mc_y, mc_z, block)}")


def print_batch():
    """Prints all five warm-up conversions in a compact table."""
    print_header()
    print()
    print("  Warm-Up Shape Points (A → B → C → D → E → A)")
    print()
    print(f"  {'Point':<8} {'Graph (x,y)':<16} {'Minecraft (X,Y,Z)':<22} {'Block':<14} {'Command'}")
    print(f"  {'-'*8} {'-'*16} {'-'*22} {'-'*14} {'-'*35}")

    for label, gx, gy, block, colour in WARMUP_POINTS:
        mc_x, mc_y, mc_z = graph_to_minecraft(gx, gy)
        graph_str = f"({gx}, {gy})"
        mc_str = f"({mc_x}, {mc_y}, {mc_z})"
        cmd = setblock_command(mc_x, mc_y, mc_z, block)
        print(f"  {label:<8} {graph_str:<16} {mc_str:<22} {colour:<14} {cmd}")

    print()
    print("  📌 Note: Math Y maps to Minecraft Z.")
    print("     Positive Y on graph paper = South (positive Z) in Minecraft.")
    print("     This is a great discussion point! Is that a coincidence?")
    print()


def print_reverse(mc_x, mc_z):
    gx, gy = minecraft_to_graph(mc_x, mc_z)
    print()
    print(f"  Minecraft XZ: ({mc_x}, {mc_z})")
    print(f"  → Graph paper point: ({gx}, {gy})")
    print()


# ---- Interactive Mode --------------------------------------------

def run_interactive():
    print_header()
    print()
    print("  Choose a mode:")
    print("  1 — Graph paper (x, y)  →  Minecraft X Y Z  +  /setblock command")
    print("  2 — Minecraft X Z       →  Graph paper (x, y)")
    print("  3 — Show all warm-up points (batch mode)")
    print("  q — Quit")
    print()

    while True:
        choice = input("  Your choice (1/2/3/q): ").strip().lower()

        if choice == "q":
            break

        elif choice == "1":
            try:
                raw = input("  Enter graph paper point as: x y  (e.g. 2 3): ").strip()
                gx, gy = map(int, raw.split())
                print_single_conversion("?", gx, gy)
            except ValueError:
                print("  ⚠️  Enter two integers separated by a space.")

        elif choice == "2":
            try:
                raw = input("  Enter Minecraft X Z as: X Z  (e.g. 100 -50): ").strip()
                mc_x, mc_z = map(int, raw.split())
                print_reverse(mc_x, mc_z)
            except ValueError:
                print("  ⚠️  Enter two integers separated by a space.")

        elif choice == "3":
            print_batch()

        else:
            print("  ⚠️  Please type 1, 2, 3, or q.")

        print()

    print("  Goodbye! 🗺️\n")


# ---- Entry Point -------------------------------------------------

if __name__ == "__main__":
    args = sys.argv[1:]

    if args and args[0] == "--batch":
        print_batch()

    elif args and args[0] == "--single" and len(args) == 3:
        try:
            gx, gy = int(args[1]), int(args[2])
            print_header()
            print_single_conversion("Input", gx, gy)
            print()
        except ValueError:
            print("Usage: python coordinate_converter.py --single x y")

    else:
        run_interactive()
