## MusicManager.gd
## ============================================================
## STEM Through Games – Day 15: Animations, Sound & Game Feel
## ============================================================
##
## A global autoload script that manages background music.
##
## Because music should persist across scene changes and
## not reset when the player respawns, we put it in an Autoload.
##
## HOW TO SET UP AS AUTOLOAD:
##   1. In Godot: Project → Project Settings → Autoload
##   2. Click the folder icon, select this file
##   3. Set Node Name to "MusicManager"
##   4. Enable the toggle and click Add
##   Now you can call MusicManager.play_track() from any script!
##
## ============================================================

extends Node

# ── AUDIO PLAYERS ────────────────────────────────────────────
## We use two players so we can crossfade between tracks
var _player_a: AudioStreamPlayer
var _player_b: AudioStreamPlayer
var _active_player: AudioStreamPlayer  # Which one is currently playing

# ── VOLUME SETTINGS ──────────────────────────────────────────
## Master volume multiplier (0.0 = silent, 1.0 = full)
var music_volume: float = 0.8

# ── CROSSFADE ────────────────────────────────────────────────
const CROSSFADE_TIME := 1.5  # seconds


# ════════════════════════════════════════════════════════════
# _ready()
# ════════════════════════════════════════════════════════════
func _ready() -> void:
	_player_a = AudioStreamPlayer.new()
	_player_b = AudioStreamPlayer.new()
	_player_a.bus = "Music"
	_player_b.bus = "Music"
	add_child(_player_a)
	add_child(_player_b)
	_active_player = _player_a


# ════════════════════════════════════════════════════════════
# play_track() – Play a music file, optionally crossfading
##
## Usage:
##   MusicManager.play_track(preload("res://audio/bg_music.ogg"))
##   MusicManager.play_track(preload("res://audio/boss.ogg"), true)
# ════════════════════════════════════════════════════════════
func play_track(stream: AudioStream, crossfade: bool = false) -> void:
	if crossfade and _active_player.playing:
		_crossfade_to(stream)
	else:
		_active_player.stream = stream
		_active_player.volume_db = linear_to_db(music_volume)
		_active_player.play()


# ════════════════════════════════════════════════════════════
# stop() – Stop music (with optional fade out)
# ════════════════════════════════════════════════════════════
func stop(fade_out: bool = true) -> void:
	if fade_out:
		var tween := create_tween()
		tween.tween_property(_active_player, "volume_db",
			linear_to_db(0.0), CROSSFADE_TIME)
		await tween.finished
	_active_player.stop()


# ════════════════════════════════════════════════════════════
# set_volume() – Change music volume smoothly
## vol is 0.0 to 1.0
# ════════════════════════════════════════════════════════════
func set_volume(vol: float) -> void:
	music_volume = clamp(vol, 0.0, 1.0)
	var tween := create_tween()
	tween.tween_property(_active_player, "volume_db",
		linear_to_db(music_volume), 0.3)


# ════════════════════════════════════════════════════════════
# _crossfade_to() – Fade out current track, fade in new one
# ════════════════════════════════════════════════════════════
func _crossfade_to(stream: AudioStream) -> void:
	var incoming := _player_b if _active_player == _player_a else _player_a
	incoming.stream = stream
	incoming.volume_db = linear_to_db(0.0)
	incoming.play()

	var tween := create_tween().set_parallel(true)
	tween.tween_property(_active_player, "volume_db",
		linear_to_db(0.0), CROSSFADE_TIME)
	tween.tween_property(incoming, "volume_db",
		linear_to_db(music_volume), CROSSFADE_TIME)

	await tween.finished
	_active_player.stop()
	_active_player = incoming


# ════════════════════════════════════════════════════════════
# ── 🧮 MATH DEEP DIVE ────────────────────────────────────────
# ════════════════════════════════════════════════════════════
#
# DECIBELS vs LINEAR VOLUME:
#   Audio volume is measured in decibels (dB), not 0–1.
#   The conversion is: dB = 20 × log₁₀(linear)
#
#   linear_to_db() does this for us. But notice:
#     linear 1.0  → 0 dB    (full volume)
#     linear 0.5  → -6 dB   (half volume)
#     linear 0.25 → -12 dB  (quarter volume)
#     linear 0.0  → -80 dB  (silence, Godot's minimum)
#
#   This is NOT linear math — it's LOGARITHMIC.
#   That's why turning a volume knob from 10 to 5 doesn't
#   sound like it halved the volume.
#
# CHALLENGE: What linear value equals -20 dB?
#   Rearrange: linear = 10^(dB/20) = 10^(-20/20) = 10^(-1) = 0.1
#
# ════════════════════════════════════════════════════════════
