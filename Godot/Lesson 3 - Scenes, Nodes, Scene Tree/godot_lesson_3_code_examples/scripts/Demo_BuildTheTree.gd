extends Control
## Demo_BuildTheTree.gd
## Students click "Add Node" buttons to build the scene tree step by step.
## The right panel shows the live tree; the left panel shows the 2D preview.

# Tree structure definition
const TREE_STEPS := [
	{
		"button": "① Add Node2D root → name it \"World\"",
		"node_path": ["World"],
		"type": "Node2D",
		"color": Color(0.29, 0.25, 0.69),
		"message": "[b]Node2D[/b] is the root of a 2D scene. Everything else will be a child of World. Think of it as the container for the whole game level.",
		"viewport_hint": "An empty world. Nothing to see yet — but the foundation is laid!"
	},
	{
		"button": "② Add Sprite2D → child of World → \"Player\"",
		"node_path": ["World", "Player"],
		"type": "Sprite2D",
		"color": Color(0.06, 0.43, 0.34),
		"message": "[b]Sprite2D[/b] renders the player's image. It's a [i]child[/i] of World — indented under it in the tree. In the viewport it appears as a blue circle.",
		"viewport_hint": "The Player sprite appears. It's a child of World."
	},
	{
		"button": "③ Add CollisionShape2D → child of Player → \"HitBox\"",
		"node_path": ["World", "Player", "HitBox"],
		"type": "CollisionShape2D",
		"color": Color(0.52, 0.24, 0.11),
		"message": "[b]CollisionShape2D[/b] is a grandchild — it's nested inside Player. This means when Player moves, HitBox moves with it automatically!",
		"viewport_hint": "The orange ring shows the collision boundary around the player."
	},
	{
		"button": "④ Add Label → child of Player → \"NameTag\"",
		"node_path": ["World", "Player", "NameTag"],
		"type": "Label",
		"color": Color(0.09, 0.37, 0.65),
		"message": "[b]Label[/b] shows the player's name. Also a child of Player — it always follows the player wherever they go.",
		"viewport_hint": "\"Hero\" floats above the player. It's anchored to the player."
	},
	{
		"button": "⑤ Add Sprite2D → child of World → \"Enemy\"",
		"node_path": ["World", "Enemy"],
		"type": "Sprite2D",
		"color": Color(0.06, 0.43, 0.34),
		"message": "Enemy is a sibling of Player — both are children of World at the same level. They don't affect each other's positions.",
		"viewport_hint": "The enemy (red circle) appears as Player's sibling."
	},
	{
		"button": "⑥ Add CollisionShape2D → child of Enemy → \"EnemyHitBox\"",
		"node_path": ["World", "Enemy", "EnemyHitBox"],
		"type": "CollisionShape2D",
		"color": Color(0.52, 0.24, 0.11),
		"message": "Each character has its own CollisionShape2D child. The tree is becoming hierarchical — groups of nodes working together.",
		"viewport_hint": "The enemy now has its own collision boundary too."
	},
	{
		"button": "⑦ Add StaticBody2D → child of World → \"Ground\"",
		"node_path": ["World", "Ground"],
		"type": "StaticBody2D",
		"color": Color(0.23, 0.42, 0.07),
		"message": "[b]StaticBody2D[/b] never moves. The ground is a sibling of Player and Enemy — all three live directly under World.",
		"viewport_hint": "The ground platform appears at the bottom. Scene complete! 🎉"
	},
]

var current_step := 0
var step_buttons := []
var tree_rows := []

var _tree_container : VBoxContainer
var _viewport_node : Control
var _message_label : RichTextLabel
var _hint_label : Label
var _progress_label : Label

# Viewport node positions
const VP_POSITIONS := {
	"Player":      Vector2(180, 150),
	"HitBox":      Vector2(180, 150),
	"NameTag":     Vector2(180, 105),
	"Enemy":       Vector2(420, 140),
	"EnemyHitBox": Vector2(420, 140),
	"Ground":      Vector2(300, 310),
}

var _vp_nodes := {}

func _ready() -> void:
	_build_ui()

func _build_ui() -> void:
	var hbox := HBoxContainer.new()
	hbox.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	hbox.add_theme_constant_override("separation", 8)
	add_child(hbox)

	# Left column: step buttons + viewport preview
	var left := VBoxContainer.new()
	left.custom_minimum_size = Vector2(320, 0)
	left.add_theme_constant_override("separation", 6)
	hbox.add_child(left)

	var steps_label := Label.new()
	steps_label.text = "Build the Scene Tree:"
	steps_label.add_theme_font_size_override("font_size", 14)
	steps_label.add_theme_color_override("font_color", Color(0.75, 0.70, 1.0))
	left.add_child(steps_label)

	_progress_label = Label.new()
	_progress_label.add_theme_font_size_override("font_size", 11)
	_progress_label.add_theme_color_override("font_color", Color(0.55, 0.55, 0.75))
	left.add_child(_progress_label)

	for i in TREE_STEPS.size():
		var btn := Button.new()
		btn.text = TREE_STEPS[i].button
		btn.custom_minimum_size = Vector2(0, 36)
		btn.add_theme_font_size_override("font_size", 12)
		btn.disabled = (i != 0)
		var idx := i
		btn.pressed.connect(func(): _do_step(idx))
		left.add_child(btn)
		step_buttons.append(btn)

	var reset_btn := Button.new()
	reset_btn.text = "↩ Reset (start over)"
	reset_btn.custom_minimum_size = Vector2(0, 36)
	reset_btn.add_theme_font_size_override("font_size", 12)
	reset_btn.pressed.connect(_reset)
	left.add_child(reset_btn)

	# Center: viewport preview
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

	_viewport_node = Control.new()
	_viewport_node.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_viewport_node.clip_contents = true
	vp_panel.add_child(_viewport_node)

	var vp_title := Label.new()
	vp_title.text = "2D Viewport Preview"
	vp_title.add_theme_font_size_override("font_size", 11)
	vp_title.add_theme_color_override("font_color", Color(0.5, 0.5, 0.7))
	vp_title.position = Vector2(8, 6)
	_viewport_node.add_child(vp_title)

	_hint_label = Label.new()
	_hint_label.text = "Click the first button to begin →"
	_hint_label.add_theme_font_size_override("font_size", 12)
	_hint_label.add_theme_color_override("font_color", Color(0.5, 0.8, 0.65))
	_hint_label.set_anchors_and_offsets_preset(Control.PRESET_BOTTOM_LEFT)
	_hint_label.offset_bottom = 0
	_hint_label.offset_left = 8
	_hint_label.offset_right = 400
	_hint_label.offset_top = -30
	_viewport_node.add_child(_hint_label)

	# Right column: live tree display + message
	var right := VBoxContainer.new()
	right.custom_minimum_size = Vector2(260, 0)
	right.add_theme_constant_override("separation", 6)
	hbox.add_child(right)

	var tree_label := Label.new()
	tree_label.text = "Scene Tree:"
	tree_label.add_theme_font_size_override("font_size", 14)
	tree_label.add_theme_color_override("font_color", Color(0.75, 0.70, 1.0))
	right.add_child(tree_label)

	var tree_panel := PanelContainer.new()
	tree_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	var tp_style := StyleBoxFlat.new()
	tp_style.bg_color = Color(0.09, 0.07, 0.18)
	tp_style.border_color = Color(0.25, 0.22, 0.50)
	tp_style.set_border_width_all(1)
	tp_style.set_corner_radius_all(6)
	tp_style.set_content_margin_all(12)
	tree_panel.add_theme_stylebox_override("panel", tp_style)
	right.add_child(tree_panel)

	_tree_container = VBoxContainer.new()
	_tree_container.add_theme_constant_override("separation", 4)
	tree_panel.add_child(_tree_container)

	var empty_lbl := Label.new()
	empty_lbl.text = "(empty — add nodes to begin)"
	empty_lbl.add_theme_font_size_override("font_size", 12)
	empty_lbl.add_theme_color_override("font_color", Color(0.45, 0.45, 0.65))
	_tree_container.add_child(empty_lbl)

	_message_label = RichTextLabel.new()
	_message_label.bbcode_enabled = true
	_message_label.fit_content = true
	_message_label.custom_minimum_size = Vector2(0, 100)
	_message_label.add_theme_font_size_override("normal_font_size", 12)
	_message_label.add_theme_color_override("default_color", Color(0.82, 0.80, 0.95))
	_message_label.text = "Add nodes one at a time to build your scene tree!"
	right.add_child(_message_label)

	_update_progress()

func _do_step(idx: int) -> void:
	if idx != current_step:
		return
	var step := TREE_STEPS[idx]

	# Add to tree display
	_add_tree_row(step)

	# Add to viewport
	_add_viewport_node(step)

	# Update message
	_message_label.text = step.message
	_hint_label.text = step.viewport_hint

	# Unlock next button
	step_buttons[idx].disabled = true
	current_step += 1
	if current_step < step_buttons.size():
		step_buttons[current_step].disabled = false

	_update_progress()

func _add_tree_row(step: Dictionary) -> void:
	# Clear "empty" label on first add
	if _tree_container.get_child_count() == 1 and _tree_container.get_child(0) is Label:
		_tree_container.get_child(0).queue_free()

	var path : Array = step.node_path
	var indent := path.size() - 1
	var node_name : String = path[-1]

	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 4)
	_tree_container.add_child(row)
	tree_rows.append(row)

	# Indent spacer
	if indent > 0:
		var spacer := Label.new()
		spacer.text = "  ".repeat(indent) + "└─ "
		spacer.add_theme_font_size_override("font_size", 13)
		spacer.add_theme_color_override("font_color", Color(0.40, 0.38, 0.60))
		row.add_child(spacer)

	# Color swatch
	var swatch := ColorRect.new()
	swatch.color = step.color
	swatch.custom_minimum_size = Vector2(10, 18)
	row.add_child(swatch)

	# Node name
	var name_lbl := Label.new()
	name_lbl.text = " " + node_name
	name_lbl.add_theme_font_size_override("font_size", 13)
	name_lbl.add_theme_color_override("font_color", Color(0.9, 0.88, 1.0))
	row.add_child(name_lbl)

	# Node type
	var type_lbl := Label.new()
	type_lbl.text = " [" + step.type + "]"
	type_lbl.add_theme_font_size_override("font_size", 11)
	type_lbl.add_theme_color_override("font_color", Color(
		step.color.r + 0.25, step.color.g + 0.25, step.color.b + 0.25, 1.0))
	row.add_child(type_lbl)

	# Flash animation
	var tween := create_tween()
	name_lbl.add_theme_color_override("font_color", Color(1.0, 0.95, 0.5))
	tween.tween_property(name_lbl, "theme_override_colors/font_color",
		Color(0.9, 0.88, 1.0), 0.8)

func _add_viewport_node(step: Dictionary) -> void:
	var node_name : String = step.node_path[-1]
	var color := step.color

	match step.type:
		"Node2D":
			# World bounding box
			var rect := ColorRect.new()
			rect.color = Color(color.r, color.g, color.b, 0.12)
			rect.size = Vector2(550, 360)
			rect.position = Vector2(20, 30)
			_viewport_node.add_child(rect)
			var lbl := Label.new()
			lbl.text = "World (Node2D)"
			lbl.add_theme_font_size_override("font_size", 11)
			lbl.add_theme_color_override("font_color", Color(color.r + 0.3, color.g + 0.3, color.b + 0.3))
			lbl.position = Vector2(24, 32)
			_viewport_node.add_child(lbl)
			_vp_nodes["World"] = rect
		"Sprite2D":
			var circle := _make_circle_node(node_name, color, 28)
			var pos := VP_POSITIONS.get(node_name, Vector2(200, 200))
			circle.position = pos - Vector2(28, 28)
			_viewport_node.add_child(circle)
			_vp_nodes[node_name] = circle
			# Entrance tween
			circle.scale = Vector2(0.1, 0.1)
			circle.modulate.a = 0
			var tw := create_tween()
			tw.set_parallel(true)
			tw.tween_property(circle, "scale", Vector2(1, 1), 0.3).set_ease(Tween.EASE_OUT)
			tw.tween_property(circle, "modulate:a", 1.0, 0.3)
		"CollisionShape2D":
			var ring := _make_ring_node(node_name, color)
			var parent_name := step.node_path[-2]
			var parent_pos := VP_POSITIONS.get(parent_name, Vector2(200, 200))
			ring.position = parent_pos - Vector2(38, 38)
			_viewport_node.add_child(ring)
			_vp_nodes[node_name] = ring
			ring.modulate.a = 0
			var tw := create_tween()
			tw.tween_property(ring, "modulate:a", 1.0, 0.4)
		"Label":
			var lbl_node := _make_label_node(node_name, "Hero")
			var parent_pos := VP_POSITIONS.get(step.node_path[-2], Vector2(200, 200))
			lbl_node.position = parent_pos - Vector2(25, 50)
			_viewport_node.add_child(lbl_node)
			_vp_nodes[node_name] = lbl_node
			lbl_node.modulate.a = 0
			var tw := create_tween()
			tw.tween_property(lbl_node, "modulate:a", 1.0, 0.4)
		"StaticBody2D":
			var ground := _make_ground_node()
			_viewport_node.add_child(ground)
			_vp_nodes["Ground"] = ground
			ground.modulate.a = 0
			var tw := create_tween()
			tw.tween_property(ground, "modulate:a", 1.0, 0.4)

func _make_circle_node(node_name: String, color: Color, radius: int) -> Control:
	var c := Control.new()
	c.custom_minimum_size = Vector2(radius*2, radius*2)
	c.size = Vector2(radius*2, radius*2)

	var circle := ColorRect.new()  # We'll draw with a Panel that's round
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.corner_radius_top_left = radius
	style.corner_radius_top_right = radius
	style.corner_radius_bottom_left = radius
	style.corner_radius_bottom_right = radius
	style.border_color = Color(1, 1, 1, 0.6)
	style.set_border_width_all(2)
	var panel := PanelContainer.new()
	panel.size = Vector2(radius*2, radius*2)
	panel.add_theme_stylebox_override("panel", style)
	c.add_child(panel)

	var lbl := Label.new()
	lbl.text = node_name[0]
	lbl.add_theme_font_size_override("font_size", 16)
	lbl.add_theme_color_override("font_color", Color(1, 1, 1, 0.9))
	lbl.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	lbl.offset_left = -8
	lbl.offset_right = 8
	lbl.offset_top = -12
	lbl.offset_bottom = 12
	panel.add_child(lbl)
	return c

func _make_ring_node(_node_name: String, color: Color) -> Control:
	var c := Control.new()
	c.size = Vector2(76, 76)
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0, 0, 0, 0)
	style.border_color = Color(color.r, color.g, color.b, 0.8)
	style.set_border_width_all(3)
	style.corner_radius_top_left = 38
	style.corner_radius_top_right = 38
	style.corner_radius_bottom_left = 38
	style.corner_radius_bottom_right = 38
	var panel := PanelContainer.new()
	panel.size = Vector2(76, 76)
	panel.add_theme_stylebox_override("panel", style)
	c.add_child(panel)
	return c

func _make_label_node(_node_name: String, display_text: String) -> Control:
	var lbl := Label.new()
	lbl.text = display_text
	lbl.add_theme_font_size_override("font_size", 13)
	lbl.add_theme_color_override("font_color", Color(0.4, 0.8, 1.0))
	return lbl

func _make_ground_node() -> Control:
	var c := Control.new()
	c.size = Vector2(550, 30)
	c.position = Vector2(20, 345)
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.13, 0.55, 0.13)
	style.border_color = Color(0.8, 0.8, 0.8, 0.4)
	style.border_width_top = 2
	var panel := PanelContainer.new()
	panel.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	panel.add_theme_stylebox_override("panel", style)
	c.add_child(panel)
	var lbl := Label.new()
	lbl.text = "Ground (StaticBody2D)"
	lbl.add_theme_font_size_override("font_size", 11)
	lbl.add_theme_color_override("font_color", Color(0.8, 1.0, 0.8))
	lbl.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	panel.add_child(lbl)
	return c

func _reset() -> void:
	current_step = 0
	for btn in step_buttons:
		btn.disabled = true
	step_buttons[0].disabled = false

	for row in tree_rows:
		row.queue_free()
	tree_rows.clear()

	for child in _tree_container.get_children():
		child.queue_free()
	var empty_lbl := Label.new()
	empty_lbl.text = "(empty — add nodes to begin)"
	empty_lbl.add_theme_font_size_override("font_size", 12)
	empty_lbl.add_theme_color_override("font_color", Color(0.45, 0.45, 0.65))
	_tree_container.add_child(empty_lbl)

	for key in _vp_nodes:
		if is_instance_valid(_vp_nodes[key]):
			_vp_nodes[key].queue_free()
	_vp_nodes.clear()
	# Remove all non-persistent viewport children (except title + hint)
	for child in _viewport_node.get_children():
		if child != _hint_label and not (child is Label and child.get_index() == 0):
			child.queue_free()

	_message_label.text = "Add nodes one at a time to build your scene tree!"
	_hint_label.text = "Click the first button to begin →"
	_update_progress()

func _update_progress() -> void:
	_progress_label.text = "Progress: %d / %d nodes added" % [current_step, TREE_STEPS.size()]

func get_info_text() -> String:
	return "[b][color=#b3aaff]Tab 2 – Build the Tree[/color][/b]   Add nodes one at a time using the buttons on the left. Watch the [b]Scene Tree[/b] grow on the right and see each node appear in the 2D preview. Use [b]Reset[/b] to start over."
