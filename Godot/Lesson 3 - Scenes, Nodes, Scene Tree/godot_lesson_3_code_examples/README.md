# STEM through Games – Day 3: Scene Tree Explorer
### A Godot 4 Interactive Lesson Project

---

## 🎮 What This Is

An interactive Godot 4 project for **middle school students** exploring the concepts from Day 3 of the STEM through Games curriculum:

- What are nodes and what do they do?
- How does the Scene Tree hierarchy work?
- How do parent nodes control child nodes?
- How does relative position math work?

---

## 🚀 How to Open

1. Install **Godot 4.2+** from https://godotengine.org/download
2. Open Godot → click **Import** → navigate to this folder → select `project.godot`
3. Press **F5** (or the Play button ▶) to run

---

## 📚 The Four Tabs

### ① What is a Node?
Click each node type card to see:
- What the node does
- When to use it
- A real example

**Node types covered:** Node2D, Sprite2D, CollisionShape2D, Label, StaticBody2D, CharacterBody2D, AnimationPlayer, AudioStreamPlayer2D

---

### ② Build the Tree
Step-by-step scene construction:
- Click buttons to add nodes one at a time
- Watch the **Scene Tree panel** on the right grow
- See each node appear in the **2D Viewport preview**
- Use **Reset** to start over and try again

**Nodes added:** World → Player → HitBox → NameTag → Enemy → EnemyHitBox → Ground

---

### ③ Parent & Child
**Drag** the colored nodes in the viewport:
- Drag **Player** → HitBox, NameTag, and Sword all follow
- Drag **HitBox** alone → Player stays, only HitBox moves
- Drag **Enemy** → EnemyHitBox follows

The **Live Positions** panel shows world coordinates vs. local offsets updating in real time.

---

### ④ Position Math
Interactive formula explorer:
- Adjust **Parent X/Y sliders** to move the Player
- Adjust **Child Local Offset sliders** to change the child's relative position
- The formula `child_world = parent_pos + child_local` updates live
- Five **Practice Challenges** with type-in answers and instant feedback

---

## 🎯 Lesson Alignment

| Demo | Lesson Objective |
|------|-----------------|
| Tab 1 – What is a Node? | Identify and describe different node types |
| Tab 2 – Build the Tree | Create a scene with multiple nodes; understand hierarchy |
| Tab 3 – Parent & Child | Distinguish parent vs. child; observe movement propagation |
| Tab 4 – Position Math | `child_world = parent_pos + child_local_offset` |

---

## 🛠 Project Structure

```
project.godot          ← Godot project config (open this)
scenes/
  Main.tscn            ← Root scene (tab navigation UI)
  demos/
    Demo_WhatIsANode.tscn
    Demo_BuildTheTree.tscn
    Demo_ParentChild.tscn
    Demo_MathPosition.tscn
scripts/
  Main.gd
  Demo_WhatIsANode.gd
  Demo_BuildTheTree.gd
  Demo_ParentChild.gd
  Demo_MathPosition.gd
assets/
  sprites/             ← Generated PNG sprites
```

---

## 📝 For Teachers

- All four demos work independently — you can start on any tab
- Tab 3 (Parent & Child) is the most hands-on; great for projected demos
- Tab 4 (Position Math) links to the coordinate geometry objectives
- The project uses only built-in Godot UI nodes — no external assets required beyond the included sprites

---

*STEM through Games Program · Day 3 of series · Requires Godot 4.2+*
