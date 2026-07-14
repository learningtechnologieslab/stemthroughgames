extends Control
## Demo_WhatIsANode.gd
## Shows all common node types as clickable cards.
## Clicking a card highlights it and explains what that node type does.

const NODE_DATA := [
	{
		"name": "Node2D",
		"icon": "📦",
		"role": "Root / Container",
		"desc": "The base 2D node. Holds [b]position[/b], [b]rotation[/b], and [b]scale[/b]. Almost everything in a 2D game inherits from this. Use it as an empty container to group objects.",
		"color": Color(0.29, 0.25, 0.69),
		"example": "Parent node for your whole scene — e.g. \"World\" or \"Player\""
	},
	{
		"name": "Sprite2D",
		"icon": "🖼",
		"role": "Visual Image",
		"desc": "Draws a [b]texture (image)[/b] on screen. This is what makes your character actually look like something. Attach a PNG to its Texture property.",
		"color": Color(0.06, 0.43, 0.34),
		"example": "The player's character art, enemy sprite, coin graphic"
	},
	{
		"name": "CollisionShape2D",
		"icon": "🔲",
		"role": "Hitbox / Physics Shape",
		"desc": "Defines the [b]invisible shape[/b] used for collision detection. Without this, physics bodies pass through each other. Common shapes: RectangleShape2D, CircleShape2D.",
		"color": Color(0.52, 0.24, 0.11),
		"example": "The hit area around a player, wall boundary, coin pickup zone"
	},
	{
		"name": "Label",
		"icon": "🏷",
		"role": "Text Display",
		"desc": "Renders [b]text[/b] on screen. Use it for names, scores, dialogue, and UI. You can style it with font size, color, and outline.",
		"color": Color(0.09, 0.37, 0.65),
		"example": "Player name tag floating above a character, score display"
	},
	{
		"name": "StaticBody2D",
		"icon": "🧱",
		"role": "Immovable Physics Body",
		"desc": "A physics body that [b]never moves[/b]. Perfect for ground, walls, and platforms. Pair it with CollisionShape2D so other objects collide with it.",
		"color": Color(0.23, 0.42, 0.07),
		"example": "Ground platform, wall, ceiling, obstacle"
	},
	{
		"name": "CharacterBody2D",
		"icon": "🏃",
		"role": "Movable Player Body",
		"desc": "A physics body [b]you control with code[/b]. Use move_and_slide() to move it and it will automatically collide with StaticBody2D. The standard choice for a player character.",
		"color": Color(0.52, 0.31, 0.04),
		"example": "Player character, NPC that walks around"
	},
	{
		"name": "AnimationPlayer",
		"icon": "🎬",
		"role": "Animation Controller",
		"desc": "Plays [b]timeline-based animations[/b]. You keyframe any property — position, scale, color, visibility — and it tweens between them. Lives as a child of what it animates.",
		"color": Color(0.60, 0.15, 0.35),
		"example": "Walk cycle, coin spin, door opening, UI fade-in"
	},
	{
		"name": "AudioStreamPlayer2D",
		"icon": "🔊",
		"role": "Spatial Sound",
		"desc": "Plays [b]audio with 2D positioning[/b]. Sound gets louder when the listener is close, quieter when far. Attach an AudioStream resource.",
		"color": Color(0.20, 0.20, 0.45),
		"example": "Footsteps, sword swing, enemy growl, ambient music"
	},
]

var selected_idx := -1
var cards := []

func _ready() -> void:
	_build_ui()

func _build_ui() -> void:
	var hbox := HBoxContainer.new()
	hbox.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	hbox.add_theme_constant_override("separation", 0)
	add_child(hbox)

	# Left: scrollable card grid
	var scroll := ScrollContainer.new()
	scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	hbox.add_child(scroll)

	var grid := GridContainer.new()
	grid.columns = 2
	grid.add_theme_constant_override("h_separation", 10)
	grid.add_theme_constant_override("v_separation", 10)
	grid.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	scroll.add_child(grid)

	for i in NODE_DATA.size():
		var card := _make_card(i)
		grid.add_child(card)
		cards.append(card)

	# Right: detail panel
	var detail := _make_detail_panel()
	hbox.add_child(detail)

func _make_card(idx: int) -> PanelContainer:
	var data := NODE_DATA[idx]
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(220, 90)
	panel.mouse_filter = Control.MOUSE_FILTER_STOP

	var style := StyleBoxFlat.new()
	style.bg_color = Color(data.color.r, data.color.g, data.color.b, 0.18)
	style.border_color = data.color
	style.border_width_left = 4
	style.content_margin_left = 12
	style.content_margin_right = 10
	style.content_margin_top = 8
	style.content_margin_bottom = 8
	style.corner_radius_top_left = 6
	style.corner_radius_top_right = 6
	style.corner_radius_bottom_left = 6
	style.corner_radius_bottom_right = 6
	panel.add_theme_stylebox_override("panel", style)

	var vbox := VBoxContainer.new()
	panel.add_child(vbox)

	var title_row := HBoxContainer.new()
	vbox.add_child(title_row)

	var icon_lbl := Label.new()
	icon_lbl.text = data.icon
	icon_lbl.add_theme_font_size_override("font_size", 22)
	title_row.add_child(icon_lbl)

	var name_lbl := Label.new()
	name_lbl.text = data.name
	name_lbl.add_theme_font_size_override("font_size", 15)
	name_lbl.add_theme_color_override("font_color", Color(0.95, 0.93, 1.0))
	name_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	title_row.add_child(name_lbl)

	var role_lbl := Label.new()
	role_lbl.text = data.role
	role_lbl.add_theme_font_size_override("font_size", 11)
	role_lbl.add_theme_color_override("font_color", Color(data.color.r + 0.3, data.color.g + 0.3, data.color.b + 0.3, 1.0))
	vbox.add_child(role_lbl)

	var hint := Label.new()
	hint.text = "Click to learn more →"
	hint.add_theme_font_size_override("font_size", 10)
	hint.add_theme_color_override("font_color", Color(0.6, 0.6, 0.8))
	vbox.add_child(hint)

	# Click detection via GUI input
	panel.gui_input.connect(func(event): _on_card_clicked(event, idx))
	return panel

func _on_card_clicked(event: InputEvent, idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_select_card(idx)

func _select_card(idx: int) -> void:
	selected_idx = idx
	# Update card visuals
	for i in cards.size():
		var style := cards[i].get_theme_stylebox("panel") as StyleBoxFlat
		var data := NODE_DATA[i]
		if i == idx:
			style.bg_color = Color(data.color.r, data.color.g, data.color.b, 0.45)
			style.border_width_left = 6
		else:
			style.bg_color = Color(data.color.r, data.color.g, data.color.b, 0.18)
			style.border_width_left = 4

	# Update detail panel
	var data := NODE_DATA[idx]
	_update_detail(data)

var _detail_title : Label
var _detail_icon  : Label
var _detail_role  : Label
var _detail_desc  : RichTextLabel
var _detail_example: Label

func _make_detail_panel() -> Control:
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(320, 0)

	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.12, 0.10, 0.22)
	style.border_color = Color(0.29, 0.25, 0.69)
	style.border_width_left = 3
	style.content_margin_left = 20
	style.content_margin_right = 16
	style.content_margin_top = 20
	style.content_margin_bottom = 16
	panel.add_theme_stylebox_override("panel", style)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 10)
	panel.add_child(vbox)

	_detail_icon = Label.new()
	_detail_icon.text = "👈"
	_detail_icon.add_theme_font_size_override("font_size", 40)
	_detail_icon.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(_detail_icon)

	_detail_title = Label.new()
	_detail_title.text = "Select a node type"
	_detail_title.add_theme_font_size_override("font_size", 20)
	_detail_title.add_theme_color_override("font_color", Color(0.85, 0.82, 1.0))
	_detail_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(_detail_title)

	_detail_role = Label.new()
	_detail_role.text = "← Click any card on the left"
	_detail_role.add_theme_font_size_override("font_size", 12)
	_detail_role.add_theme_color_override("font_color", Color(0.65, 0.65, 0.85))
	_detail_role.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(_detail_role)

	var sep := HSeparator.new()
	vbox.add_child(sep)

	_detail_desc = RichTextLabel.new()
	_detail_desc.bbcode_enabled = true
	_detail_desc.fit_content = true
	_detail_desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_detail_desc.add_theme_font_size_override("normal_font_size", 13)
	_detail_desc.add_theme_color_override("default_color", Color(0.82, 0.80, 0.95))
	_detail_desc.text = "Each node type has a specific job. Together they build your game world!"
	vbox.add_child(_detail_desc)

	var ex_header := Label.new()
	ex_header.text = "Example use:"
	ex_header.add_theme_font_size_override("font_size", 11)
	ex_header.add_theme_color_override("font_color", Color(0.55, 0.55, 0.75))
	vbox.add_child(ex_header)

	_detail_example = Label.new()
	_detail_example.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_detail_example.add_theme_font_size_override("font_size", 13)
	_detail_example.add_theme_color_override("font_color", Color(0.4, 0.85, 0.65))
	_detail_example.text = ""
	vbox.add_child(_detail_example)

	return panel

func _update_detail(data: Dictionary) -> void:
	_detail_icon.text = data.icon
	_detail_title.text = data.name
	_detail_role.text = data.role
	_detail_desc.text = data.desc
	_detail_example.text = data.example

func get_info_text() -> String:
	return "[b][color=#b3aaff]Tab 1 – What is a Node?[/color][/b]   Every object in a Godot game is a [b]node[/b]. Click each card to learn what that node type does and when to use it."
