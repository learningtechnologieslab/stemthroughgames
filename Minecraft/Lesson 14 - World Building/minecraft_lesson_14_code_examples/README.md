# Day 14 — World Building & Level Storytelling
## Code Examples & Implementation Guide

**STEM Through Games | Middle School Game Design | Grades 6–8**

This folder contains ready-to-use code examples for Day 14's main activity: building game worlds that tell stories through environmental detail rather than text.

Examples are provided for **two tools**:

| Tool | Folder | Who It's For |
|------|--------|--------------|
| Godot Engine 4.x | `godot/` | Classes using Godot |
| Minecraft Education Edition | `minecraft-education/` | Classes using Minecraft |

---

## How to Use These Examples

### For Teachers
- Each example folder has its own `README.md` with step-by-step setup instructions.
- Examples are ordered from **simplest → most complex**. Start with the basics and layer in extensions as students are ready.
- The `complete_scene` folder (Godot) shows how all the pieces fit together in a single project.

### For Students
- Copy the `.gd` script files directly into your Godot project.
- Read the comments inside each file — they explain every line.
- Look for lines marked `# 🎨 CUSTOMIZE:` — those are the parts you should change to match your own world story.

---

## Godot Examples (in order of complexity)

### 1. `godot/npc_dialogue/` — NPC Interaction (Core Lesson)
The foundational example from the lesson. An NPC that shows dialogue when the player enters its zone.

**Concepts covered:** Area2D, signals, `body_entered`, `body_exited`, `visible`
**Lesson use:** Part B, Task 2

---

### 2. `godot/environmental_details/` — Programmatic World Details
How to add and modify environmental storytelling elements using code — color tinting, random debris placement, and mood lighting.

**Concepts covered:** Modulate, Color, `randi_range()`, randomness for natural-looking worlds
**Lesson use:** Part B, Task 1 / Extension

---

### 3. `godot/flickering_light/` — Flickering Light Effect
Animate a light source to flicker using a simple timer and random energy values — a powerful atmospheric detail.

**Concepts covered:** PointLight2D, Timer, randomness, `_process()`
**Lesson use:** Extension Challenge

---

### 4. `godot/parallax_background/` — Parallax Depth Effect
Add multiple scrolling background layers to make your world feel deep and atmospheric.

**Concepts covered:** ParallaxBackground, ParallaxLayer, scroll offsets
**Lesson use:** Extension Challenge

---

### 5. `godot/complete_scene/` — Everything Together
A fully commented scene that combines NPC dialogue, a flickering light, mood color tinting, and a parallax background. Use this as a reference or a starter template.

**Lesson use:** Teacher demo / advanced students

---

## Minecraft Education Examples (in order of complexity)

### 1. `minecraft-education/npc_setup/` — NPC Dialogue Setup
Step-by-step guide and example dialogue scripts for setting up story NPCs in Minecraft Education Edition.

**Lesson use:** Part B, Task 2

---

### 2. `minecraft-education/command_blocks/` — Command Block Sequences
Ready-to-type command sequences for atmospheric effects: time of day, weather, particle effects, and sound.

**Concepts covered:** `/time`, `/weather`, `/particle`, `/playsound`
**Lesson use:** Extension Challenge

---

### 3. `minecraft-education/world_setup_guide/` — World Configuration Guide
Recommended world settings for the lesson activity, including game mode, permissions, and Education Edition features.

**Lesson use:** Teacher prep

---

## Quick Reference: Key Godot Concepts Used

| Concept | What It Does | Used In |
|---------|-------------|---------|
| `Area2D` | Detects when things enter a zone | NPC dialogue |
| `@onready` | Gets a reference to a child node at startup | NPC dialogue, lights |
| `body_entered` signal | Fires when a physics body enters Area2D | NPC dialogue |
| `.visible` | Shows or hides a node | NPC dialogue |
| `.modulate` | Tints a node's color | Environmental details |
| `PointLight2D.energy` | Controls light brightness | Flickering light |
| `Timer` | Fires signals on a time interval | Flickering light |
| `ParallaxLayer` | Creates depth-scrolling background | Parallax |
| `randf_range()` | Random float between two values | Flicker, debris |
| `randi_range()` | Random integer between two values | Debris placement |

---

## Godot 4.x Project Setup (First Time)

1. Download Godot Engine 4.x from [godotengine.org](https://godotengine.org)
2. Open Godot and click **New Project**
3. Give it a name (e.g. `Day14_WorldBuilding`) and choose a folder
4. Set **Renderer** to `Compatibility` (works on all computers)
5. Click **Create & Edit**
6. Copy the `.gd` script files from these examples into your project folder
7. Follow the setup instructions in each example's README

---

## Minecraft Education Edition Setup

1. Open Minecraft Education Edition
2. Click **Create New** → choose a world template or start with **Flat World**
3. Set **Game Mode** to `Creative` for building
4. Enable **Education Edition** features in world settings (required for NPC entities)
5. See `minecraft-education/world_setup_guide/` for full recommended settings

---

## Standards Connections

| Example | CSTA Standard | What It Demonstrates |
|---------|--------------|----------------------|
| NPC Dialogue | 2-AP-12 | Decompose problems into smaller components (interaction zone + dialogue + signal) |
| Environmental Details | 2-AP-13 | Decompose problems and create artifacts with multiple functions |
| Flickering Light | 2-AP-11 | Create clearly named variables and use them in algorithms |
| Complete Scene | 2-AP-16 | Incorporate existing code into new programs |

---

*STEM Through Games Program — Day 14 Code Examples*
*Compatible with Godot Engine 4.x and Minecraft Education Edition*
