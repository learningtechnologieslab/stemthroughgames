extends Control
## Demo_ParentChild.gd
## Draggable nodes that demonstrate parent-child movement inheritance.
## Drag the parent → children follow. Drag a child → parent stays.

const PURPLE := Color(0.29, 0.25, 0.69)
const TEAL   := Color(0.06, 0.43, 0.34)
const CORAL  := Color(0.52, 0.24, 0.11)
const BLUE   := Color(0.09, 0.37, 0.65)
const GREEN  := Color(0.23, 0.42, 0.07)
const AMBER  := Color(0.52, 0.31, 0.04)

# Node definitions: name, color, radius, initial pos, parent (or null)
# Positions are in viewport space (relative to viewport origin)
var node_defs := [
	{ "name": "World",        "color": PURPLE, "r": 0,  "pos": Vector2(0, 0),      "parent": null,    "type": "Node2D",           "is_container": true },
	{ "name": "Player",       "color": TEAL,   "r": 30, "pos": Vector2(180, 180),   "parent": "World", "type": "Sprite2D" },
	{ "name": "HitBox",       "color": CORAL,  "r": 42, "pos": Vector2(180, 180),   "parent": "Player","type": "CollisionShape2D", "ring": true },
	{ "name": "NameTag",      "color": BLUE,   "r": 0,  "pos": Vector2(180, 135),   "parent": "Player","type": "Label",            "is_label": true },
	{ "name": "Sword",        "color": AMBER,  "r": 10, "pos": Vector2(215, 165),   "parent": "Player","type": "Sprite2D" },
	{ "name": "Enemy",        "color": CORAL,  "r": 28, "pos": Vector2(400, 190),   "parent": "World", "type": "Sprite2D" },
	{ "name": "EnemyHitBox",  "color": Color(0.6, 0.3, 0.1), "r": 38, "pos": Vector2(400, 190), "parent": "Enemy", "type": "CollisionShape2D", "ring": true },
]

# Runtime state
var nodes_by_name := {}     # name -> dict with "control", "local_offset"
var dragging : String = ""
var drag_start_mouse := Vector2.ZERO
var drag_start_node := Vector2.ZERO

var _info_panel : RichTextLabel
var _coord_panel : RichTextLabel
var _viewport : Control

func _ready() -> void:
	_build_ui()
	_spawn_nodes()

func _build_ui() -> void:
	var hbox := HBoxContainer.new()
	hbox.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	hbox.add_theme_constant_override("separation", 8)
	add_child(hbox)

	# Left: instructions + coordinate display
	var left := VBoxContainer.new()
	left.custom_minimum_size = Vector2(270, 0)
	left.add_theme_constant_override("separation", 8)
	hbox.add_child(left)

	var instr_label := Label.new()
	instr_label.text = "How to use:"
	instr_label.add_theme_font_size_override("font_size", 14)
	instr_label.add_theme_color_override("font_color", Color(0.75, 0.70, 1.0))
	left.add_child(instr_label)

	var instructions := [
		"🟣 Drag [b]Player[/b] → watch HitBox, NameTag, and Sword follow",
		"🔴 Drag [b]HitBox[/b] alone → Player stays put",
		"🔴 Drag [b]Enemy[/b] → its HitBox follows",
		"Notice: World contains everyone — it's the parent of all",
	]
	for instr in instructions:
		var lbl := RichTextLabel.new()
		lbl.bbcode_enabled = true
		lbl.fit_content = true
		lbl.text = "• " + instr
		lbl.add_theme_font_size_override("normal_font_size", 12)
		lbl.add_theme_color_override("default_color", Color(0.80, 0.78, 0.95))
		left.add_child(lbl)

	var sep := HSeparator.new()
	left.add_child(sep)

	var coord_title := Label.new()
	coord_title.text = "Live Positions:"
	coord_title.add_theme_font_size_override("font_size", 13)
	coord_title.add_theme_color_override("font_color", Color(0.75, 0.70, 1.0))
	left.add_child(coord_title)

	_coord_panel = RichTextLabel.new()
	_coord_panel.bbcode_enabled = true
	_coord_panel.fit_content = false
	_coord_panel.custom_minimum_size = Vector2(0, 200)
	_coord_panel.add_theme_font_size_override("normal_font_size", 12)
	_coord_panel.add_theme_color_override("default_color", Color(0.78, 0.76, 0.95))
	left.add_child(_coord_panel)

	var sep2 := HSeparator.new()
	left.add_child(sep2)

	_info_panel = RichTextLabel.new()
	_info_panel.bbcode_enabled = true
	_info_panel.fit_content = true
	_info_panel.custom_minimum_size = Vector2(0, 80)
	_info_panel.add_theme_font_size_override("normal_font_size", 12)
	_info_panel.add_theme_color_override("default_color", Color(0.5, 0.9, 0.7))
	_info_panel.text = "Drag any colored node!"
	left.add_child(_info_panel)

	var reset_btn := Button.new()
	reset_btn.text = "↩ Reset positions"
	reset_btn.pressed.connect(_reset_positions)
	left.add_child(reset_btn)

	# Right: viewport canvas
	var vp_panel := PanelContainer.new()
	vp_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	vp_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	var vp_style := StyleBoxFlat.new()
	vp_style.bg_color = Color(0.07, 0.06, 0.14)
	vp_style.border_color = Color(0.25, 0.22, 0.50)
	vp_style.set_border_width_all(1)
	vp_style.set_corner_radius_all(6)
	vp_panel.add_theme_stylebox_override("panel", vp_style)
	hbox.add_child(vp_panel)

	_viewport = Control.new()
	_viewport.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_viewport.clip_contents = true
	vp_panel.add_child(_viewport)

	var vp_hint := Label.new()
	vp_hint.text = "← Drag the colored nodes"
	vp_hint.add_theme_font_size_override("font_size", 11)
	vp_hint.add_theme_color_override("font_color", Color(0.4, 0.4, 0.6))
	vp_hint.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_RIGHT)
	vp_hint.offset_bottom = 0
	vp_hint.offset_right = -6
	vp_hint.offset_top = -22
	vp_hint.offset_left = -200
	_viewport.add_child(vp_hint)

func _spawn_nodes() -> void:
	# Draw connection lines first (behind nodes)
	var line_layer := Control.new()
	line_layer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	line_layer.name = "LineLayer"
	_viewport.add_child(line_layer)

	for def in node_defs:
		if def.get("is_container", false):
			continue
		var ctrl := _make_node_control(def)
		ctrl.position = def.pos - Vector2(def.r if def.r > 0 else 25, def.r if def.r > 0 else 12)
		_viewport.add_child(ctrl)
		nodes_by_name[def.name] = {
			"control": ctrl,
			"def": def,
			"world_pos": def.pos,
		}

	_update_coord_display()

func _make_node_control(def: Dictionary) -> Control:
	var c := Control.new()
	c.name = def.name
	c.mouse_filter = Control.MOUSE_FILTER_STOP

	if def.get("ring", false):
		var r := def.r
		c.custom_minimum_size = Vector2(r*2, r*2)
		c.size = Vector2(r*2, r*2)
		var style := StyleBoxFlat.new()
		style.bg_color = Color(0, 0, 0, 0)
		style.border_color = Color(def.color.r, def.color.g, def.color.b, 0.9)
		style.set_border_width_all(3)
		style.corner_radius_top_left = r
		style.corner_radius_top_right = r
		style.corner_radius_bottom_left = r
		style.corner_radius_bottom_right = r
		var panel := PanelContainer.new()
		panel.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		panel.add_theme_stylebox_override("panel", style)
		c.add_child(panel)
		var lbl := Label.new()
		lbl.text = def.name
		lbl.add_theme_font_size_override("font_size", 9)
		lbl.add_theme_color_override("font_color", Color(def.color.r + 0.3, def.color.g + 0.3, def.color.b + 0.3))
		lbl.position = Vector2(r - 25, r * 2 + 2)
		c.add_child(lbl)
	elif def.get("is_label", false):
		c.custom_minimum_size = Vector2(60, 22)
		c.size = Vector2(60, 22)
		var style := StyleBoxFlat.new()
		style.bg_color = Color(def.color.r, def.color.g, def.color.b, 0.7)
		style.set_corner_radius_all(4)
		style.set_content_margin_all(3)
		var panel := PanelContainer.new()
		panel.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		panel.add_theme_stylebox_override("panel", style)
		c.add_child(panel)
		var lbl := Label.new()
		lbl.text = "Hero ♦"
		lbl.add_theme_font_size_override("font_size", 11)
		lbl.add_theme_color_override("font_color", Color(1, 1, 1, 0.95))
		lbl.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
		panel.add_child(lbl)
		var type_lbl := Label.new()
		type_lbl.text = def.name
		type_lbl.add_theme_font_size_override("font_size", 9)
		type_lbl.add_theme_color_override("font_color", Color(0.6, 0.7, 0.9))
		type_lbl.position = Vector2(0, 24)
		c.add_child(type_lbl)
	else:
		var r := def.r
		c.custom_minimum_size = Vector2(r*2, r*2)
		c.size = Vector2(r*2, r*2)
		var style := StyleBoxFlat.new()
		style.bg_color = def.color
		style.border_color = Color(1, 1, 1, 0.55)
		style.set_border_width_all(2)
		style.corner_radius_top_left = r
		style.corner_radius_top_right = r
		style.corner_radius_bottom_left = r
		style.corner_radius_bottom_right = r
		var panel := PanelContainer.new()
		panel.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		panel.add_theme_stylebox_override("panel", style)
		c.add_child(panel)
		var lbl := Label.new()
		lbl.text = def.name
		lbl.add_theme_font_size_override("font_size", 11)
		lbl.add_theme_color_override("font_color", Color(1, 1, 1, 0.9))
		lbl.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
		lbl.offset_left = -30; lbl.offset_right = 30
		lbl.offset_top = -10; lbl.offset_bottom = 10
		panel.add_child(lbl)

	c.gui_input.connect(func(ev): _on_node_input(ev, def.name))
	return c

func _on_node_input(event: InputEvent, node_name: String) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = node_name
				drag_start_mouse = event.global_position
				drag_start_node = nodes_by_name[node_name].world_pos
				_info_panel.text = "[b]Dragging:[/b] " + node_name + "\n" + _get_drag_hint(node_name)
			else:
				dragging = ""
	elif event is InputEventMouseMotion and dragging == node_name:
		var delta := event.global_position - drag_start_mouse
		var new_pos := drag_start_node + delta
		_move_node_world(node_name, new_pos)

func _get_drag_hint(node_name: String) -> String:
	match node_name:
		"Player":
			return "[color=#5de0b0]Watch HitBox, NameTag, and Sword follow along![/color]"
		"Enemy":
			return "[color=#5de0b0]Watch EnemyHitBox follow along![/color]"
		"HitBox", "EnemyHitBox":
			return "[color=#ffb347]Only this node moves — the parent stays put.[/color]"
		"NameTag", "Sword":
			return "[color=#ffb347]Moving a child independently from its parent.[/color]"
	return ""

func _move_node_world(node_name: String, new_world_pos: Vector2) -> void:
	var data := nodes_by_name[node_name]
	var old_pos : Vector2 = data.world_pos
	var delta := new_world_pos - old_pos
	data.world_pos = new_world_pos

	# Find this node's def
	var def : Dictionary
	for d in node_defs:
		if d.name == node_name:
			def = d
			break

	# Move the control
	var r := def.r if def.r > 0 else 25
	data.control.position = new_world_pos - Vector2(r, r if not def.get("is_label", false) else 12)

	# Move all children recursively
	for child_name in nodes_by_name:
		var child_def : Dictionary
		for d in node_defs:
			if d.name == child_name:
				child_def = d
				break
		if child_def.get("parent", "") == node_name:
			var child_data := nodes_by_name[child_name]
			_move_node_world(child_name, child_data.world_pos + delta)

	_update_coord_display()

func _update_coord_display() -> void:
	var txt := ""
	for def in node_defs:
		if def.get("is_container", false):
			continue
		var data := nodes_by_name.get(def.name, null)
		if data == null:
			continue
		var wp : Vector2 = data.world_pos
		var parent_name : String = def.get("parent", "")
		var local_pos := wp
		if parent_name != "World" and parent_name != "" and nodes_by_name.has(parent_name):
			local_pos = wp - nodes_by_name[parent_name].world_pos

		var color_hex := "#%02x%02x%02x" % [
			int(def.color.r * 255),
			int(def.color.g * 255),
			int(def.color.b * 255)
		]
		txt += "[color=%s]%s[/color]\n" % [color_hex, def.name]
		txt += "  World: (%d, %d)\n" % [int(wp.x), int(wp.y)]
		if parent_name != "" and parent_name != "World":
			txt += "  Local: (%d, %d)\n" % [int(local_pos.x), int(local_pos.y)]
		txt += "\n"
	_coord_panel.text = txt

func _reset_positions() -> void:
	for def in node_defs:
		if def.get("is_container", false):
			continue
		if nodes_by_name.has(def.name):
			var r := def.r if def.r > 0 else 25
			nodes_by_name[def.name].world_pos = def.pos
			nodes_by_name[def.name].control.position = def.pos - Vector2(r, r if not def.get("is_label", false) else 12)
	_update_coord_display()
	_info_panel.text = "Positions reset. Drag any colored node!"

func get_info_text() -> String:
	return "[b][color=#b3aaff]Tab 3 – Parent & Child[/color][/b]   [b]Drag[/b] any colored node in the viewport. When you move a [b]parent[/b] (like Player), all its children follow. When you move a [b]child[/b] (like HitBox), only that node moves. The coordinate panel shows world vs local positions in real time."
