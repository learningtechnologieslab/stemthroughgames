extends Control
## Demo_MathPosition.gd
## Interactive coordinate math lesson.
## Students move a parent node with sliders and solve for child world position.

const PURPLE := Color(0.29, 0.25, 0.69)
const AMBER  := Color(0.72, 0.46, 0.06)
const TEAL   := Color(0.06, 0.43, 0.34)
const CORAL  := Color(0.52, 0.24, 0.11)

var parent_x := 200.0
var parent_y := 200.0
var child_local_x := 40.0
var child_local_y := -30.0

var _viewport : Control
var _parent_circle : Control
var _child_circle : Control
var _hitbox_ring : Control
var _nametag_ctrl : Control
var _formula_label : RichTextLabel
var _answer_label : RichTextLabel
var _challenge_label : RichTextLabel

# Challenge system
var _challenges := [
	{ "q": "Player is at (150, 250). HitBox local offset is (0, 0).\nWhere is HitBox in the world?", "ax": 150, "ay": 250 },
	{ "q": "Player is at (300, 180). Sword local offset is (35, -10).\nWhere is Sword in the world?", "ax": 335, "ay": 170 },
	{ "q": "Player moves from (100, 200) to (200, 200) — 100px right.\nHitBox local offset is (10, 5). What is HitBox's new world position?", "ax": 210, "ay": 205 },
	{ "q": "World node is at (0,0). Player's local offset is (180,180).\nHitBox local offset from Player is (0, 0). What is HitBox's world position?", "ax": 180, "ay": 180 },
	{ "q": "Player is at (250, 300). NameTag local is (0, -40).\nWhere does NameTag appear in the world?", "ax": 250, "ay": 260 },
]
var _current_challenge := 0
var _answer_x_field : LineEdit
var _answer_y_field : LineEdit
var _feedback_label : Label

func _ready() -> void:
	_build_ui()
	_update_display()

func _build_ui() -> void:
	var hbox := HBoxContainer.new()
	hbox.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	hbox.add_theme_constant_override("separation", 8)
	add_child(hbox)

	# Left: controls + formula
	var left := VBoxContainer.new()
	left.custom_minimum_size = Vector2(310, 0)
	left.add_theme_constant_override("separation", 8)
	hbox.add_child(left)

	var title := Label.new()
	title.text = "Position is Relative"
	title.add_theme_font_size_override("font_size", 18)
	title.add_theme_color_override("font_color", Color(0.85, 0.80, 1.0))
	left.add_child(title)

	# Formula box
	var formula_panel := PanelContainer.new()
	var fp_style := StyleBoxFlat.new()
	fp_style.bg_color = Color(0.14, 0.10, 0.04)
	fp_style.border_color = AMBER
	fp_style.border_width_top = 0; fp_style.border_width_bottom = 0
	fp_style.border_width_left = 4; fp_style.border_width_right = 0
	fp_style.set_content_margin_all(10)
	formula_panel.add_theme_stylebox_override("panel", fp_style)
	left.add_child(formula_panel)

	var formula_lbl := Label.new()
	formula_lbl.text = "child_world = parent_pos + child_local"
	formula_lbl.add_theme_font_size_override("font_size", 13)
	formula_lbl.add_theme_color_override("font_color", Color(1.0, 0.80, 0.3))
	formula_panel.add_child(formula_lbl)

	# Sliders for parent
	left.add_child(_make_section_label("Move the Parent (Player):"))

	var px_row := _make_slider_row("Parent X", 0, 500, parent_x, func(v): _on_parent_x(v))
	left.add_child(px_row)
	var py_row := _make_slider_row("Parent Y", 0, 400, parent_y, func(v): _on_parent_y(v))
	left.add_child(py_row)

	left.add_child(_make_section_label("Child Local Offset (HitBox from Player):"))
	var cx_row := _make_slider_row("Local X", -100, 100, child_local_x, func(v): _on_child_x(v))
	left.add_child(cx_row)
	var cy_row := _make_slider_row("Local Y", -100, 100, child_local_y, func(v): _on_child_y(v))
	left.add_child(cy_row)

	var sep := HSeparator.new()
	left.add_child(sep)

	# Live calculation display
	_formula_label = RichTextLabel.new()
	_formula_label.bbcode_enabled = true
	_formula_label.fit_content = true
	_formula_label.add_theme_font_size_override("normal_font_size", 13)
	_formula_label.add_theme_color_override("default_color", Color(0.85, 0.82, 0.95))
	left.add_child(_formula_label)

	_answer_label = RichTextLabel.new()
	_answer_label.bbcode_enabled = true
	_answer_label.fit_content = true
	_answer_label.add_theme_font_size_override("normal_font_size", 14)
	_answer_label.add_theme_color_override("default_color", Color(0.4, 0.9, 0.65))
	left.add_child(_answer_label)

	# Center: viewport
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

	# Draw origin dot
	var origin_lbl := Label.new()
	origin_lbl.text = "Origin (0,0)"
	origin_lbl.add_theme_font_size_override("font_size", 10)
	origin_lbl.add_theme_color_override("font_color", Color(0.4, 0.4, 0.6))
	origin_lbl.position = Vector2(4, 4)
	_viewport.add_child(origin_lbl)

	# Parent node (Player)
	_parent_circle = _make_draggable_circle("Player", TEAL, 30)
	_viewport.add_child(_parent_circle)

	# Child node (HitBox ring)
	_child_circle = _make_info_circle("HitBox", CORAL, 20)
	_viewport.add_child(_child_circle)

	# Right: challenges
	var right := VBoxContainer.new()
	right.custom_minimum_size = Vector2(280, 0)
	right.add_theme_constant_override("separation", 8)
	hbox.add_child(right)

	var ch_title := Label.new()
	ch_title.text = "Practice Challenges"
	ch_title.add_theme_font_size_override("font_size", 16)
	ch_title.add_theme_color_override("font_color", Color(1.0, 0.8, 0.35))
	right.add_child(ch_title)

	_challenge_label = RichTextLabel.new()
	_challenge_label.bbcode_enabled = true
	_challenge_label.fit_content = true
	_challenge_label.custom_minimum_size = Vector2(0, 100)
	_challenge_label.add_theme_font_size_override("normal_font_size", 12)
	_challenge_label.add_theme_color_override("default_color", Color(0.88, 0.85, 1.0))
	right.add_child(_challenge_label)

	var ans_label := Label.new()
	ans_label.text = "Your answer:"
	ans_label.add_theme_font_size_override("font_size", 12)
	ans_label.add_theme_color_override("font_color", Color(0.65, 0.65, 0.85))
	right.add_child(ans_label)

	var ans_row := HBoxContainer.new()
	right.add_child(ans_row)

	var x_lbl := Label.new(); x_lbl.text = "X:"; ans_row.add_child(x_lbl)
	_answer_x_field = LineEdit.new()
	_answer_x_field.custom_minimum_size = Vector2(70, 0)
	_answer_x_field.placeholder_text = "?"
	ans_row.add_child(_answer_x_field)

	var y_lbl := Label.new(); y_lbl.text = "  Y:"; ans_row.add_child(y_lbl)
	_answer_y_field = LineEdit.new()
	_answer_y_field.custom_minimum_size = Vector2(70, 0)
	_answer_y_field.placeholder_text = "?"
	ans_row.add_child(_answer_y_field)

	var check_btn := Button.new()
	check_btn.text = "Check ✓"
	check_btn.pressed.connect(_check_answer)
	right.add_child(check_btn)

	_feedback_label = Label.new()
	_feedback_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_feedback_label.add_theme_font_size_override("font_size", 13)
	right.add_child(_feedback_label)

	var next_btn := Button.new()
	next_btn.text = "Next Challenge →"
	next_btn.pressed.connect(_next_challenge)
	right.add_child(next_btn)

	var sep2 := HSeparator.new()
	right.add_child(sep2)

	var tip_lbl := RichTextLabel.new()
	tip_lbl.bbcode_enabled = true
	tip_lbl.fit_content = true
	tip_lbl.add_theme_font_size_override("normal_font_size", 12)
	tip_lbl.add_theme_color_override("default_color", Color(0.6, 0.6, 0.8))
	tip_lbl.text = "[b]Remember:[/b]\nworld_pos = parent_pos + local_offset\n\nA child at local (0,0) is exactly at the parent's position.\n\nNegative Y = up in Godot!"
	right.add_child(tip_lbl)

	_load_challenge()

func _make_section_label(text: String) -> Label:
	var lbl := Label.new()
	lbl.text = text
	lbl.add_theme_font_size_override("font_size", 12)
	lbl.add_theme_color_override("font_color", Color(0.65, 0.65, 0.85))
	return lbl

func _make_slider_row(label: String, min_v: float, max_v: float, current: float, callback: Callable) -> HBoxContainer:
	var row := HBoxContainer.new()
	var lbl := Label.new()
	lbl.text = label
	lbl.custom_minimum_size = Vector2(90, 0)
	lbl.add_theme_font_size_override("font_size", 12)
	row.add_child(lbl)
	var slider := HSlider.new()
	slider.min_value = min_v
	slider.max_value = max_v
	slider.value = current
	slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	slider.value_changed.connect(callback)
	row.add_child(slider)
	var val_lbl := Label.new()
	val_lbl.text = str(int(current))
	val_lbl.custom_minimum_size = Vector2(40, 0)
	val_lbl.add_theme_font_size_override("font_size", 12)
	val_lbl.add_theme_color_override("font_color", Color(0.4, 0.9, 0.65))
	slider.value_changed.connect(func(v): val_lbl.text = str(int(v)))
	row.add_child(val_lbl)
	return row

func _make_draggable_circle(label: String, color: Color, r: int) -> Control:
	return _make_circle_ctrl(label, color, r)

func _make_info_circle(label: String, color: Color, r: int) -> Control:
	return _make_circle_ctrl(label, color, r)

func _make_circle_ctrl(label: String, color: Color, r: int) -> Control:
	var c := Control.new()
	c.size = Vector2(r*2, r*2)
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.border_color = Color(1, 1, 1, 0.5)
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
	lbl.text = label
	lbl.add_theme_font_size_override("font_size", 11)
	lbl.add_theme_color_override("font_color", Color(1, 1, 1, 0.9))
	lbl.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	lbl.offset_left = -30; lbl.offset_right = 30
	lbl.offset_top = -10; lbl.offset_bottom = 10
	panel.add_child(lbl)
	return c

func _on_parent_x(v: float) -> void:
	parent_x = v; _update_display()
func _on_parent_y(v: float) -> void:
	parent_y = v; _update_display()
func _on_child_x(v: float) -> void:
	child_local_x = v; _update_display()
func _on_child_y(v: float) -> void:
	child_local_y = v; _update_display()

func _update_display() -> void:
	var child_world_x := parent_x + child_local_x
	var child_world_y := parent_y + child_local_y

	# Update viewport positions
	if _parent_circle:
		_parent_circle.position = Vector2(parent_x - 30, parent_y - 30)
	if _child_circle:
		_child_circle.position = Vector2(child_world_x - 20, child_world_y - 20)

	# Draw a line between parent and child using a ColorRect hackaround
	# (We'll update a label showing the connection)

	# Update formula display
	_formula_label.text = (
		"[b]Parent (Player) position:[/b] (%d, %d)\n" % [int(parent_x), int(parent_y)] +
		"[b]Child local offset:[/b]       (%d, %d)\n" % [int(child_local_x), int(child_local_y)] +
		"[b]─────────────────────────────[/b]\n" +
		"  (%d) + (%d) = [b]%d[/b]  (world X)\n" % [int(parent_x), int(child_local_x), int(child_world_x)] +
		"  (%d) + (%d) = [b]%d[/b]  (world Y)" % [int(parent_y), int(child_local_y), int(child_world_y)]
	)

	_answer_label.text = (
		"[b][color=#5de0b0]HitBox world position: (%d, %d)[/color][/b]" % [int(child_world_x), int(child_world_y)]
	)

func _load_challenge() -> void:
	var ch := _challenges[_current_challenge % _challenges.size()]
	_challenge_label.text = "[b]Challenge %d/%d:[/b]\n\n%s" % [
		_current_challenge + 1, _challenges.size(), ch.q
	]
	_answer_x_field.text = ""
	_answer_y_field.text = ""
	_feedback_label.text = ""

func _check_answer() -> void:
	var ch := _challenges[_current_challenge % _challenges.size()]
	var ax_str := _answer_x_field.text.strip_edges()
	var ay_str := _answer_y_field.text.strip_edges()
	if ax_str == "" or ay_str == "":
		_feedback_label.text = "Enter both X and Y values first."
		_feedback_label.add_theme_color_override("font_color", Color(1.0, 0.8, 0.3))
		return
	var ax := int(ax_str)
	var ay := int(ay_str)
	if ax == ch.ax and ay == ch.ay:
		_feedback_label.text = "✅ Correct! (%d, %d) is right." % [ch.ax, ch.ay]
		_feedback_label.add_theme_color_override("font_color", Color(0.3, 0.9, 0.5))
	else:
		_feedback_label.text = "❌ Not quite. Remember:\nworld = parent + local\nAnswer: (%d, %d)" % [ch.ax, ch.ay]
		_feedback_label.add_theme_color_override("font_color", Color(0.9, 0.4, 0.3))

func _next_challenge() -> void:
	_current_challenge = (_current_challenge + 1) % _challenges.size()
	_load_challenge()

func get_info_text() -> String:
	return "[b][color=#b3aaff]Tab 4 – Position Math[/color][/b]   Use the sliders to move the [b]Parent[/b] node and adjust the [b]child's local offset[/b]. Watch the formula update in real time. Then try the [b]Practice Challenges[/b] on the right — type in your answer and check it!"
