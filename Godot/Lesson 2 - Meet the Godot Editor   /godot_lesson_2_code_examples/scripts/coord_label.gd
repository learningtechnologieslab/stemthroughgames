## coord_label.gd
## STEM Through Games – Day 2
##
## Attached to the PlayerCoord label in the UI.
## This is a minimal script — all the real updates happen in main.gd.
## The label is updated there because main.gd has access to the player node.

extends Label

# No logic needed here — updates come from main.gd's _process().
# This file exists so the scene reference stays clean.
