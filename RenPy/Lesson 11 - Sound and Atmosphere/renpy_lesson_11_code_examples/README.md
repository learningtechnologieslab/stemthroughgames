# Day 11 – Sound & Atmosphere
## Ren'Py Example Files — Teacher Guide

---

## What's In This Folder

| File | When to Use | Who Uses It |
|------|-------------|-------------|
| `01_warmup_demo.rpy` | Minutes 0–5 | Teacher demonstrates on projector |
| `02_guided_practice.rpy` | Minutes 12–22 | Students follow along, step by step |
| `03_mood_experiment.rpy` | Minutes 22–38 | Students run independently with worksheet |
| `04_full_project_example.rpy` | Any time | Student reference / remix template |
| `05_challenge_extension.rpy` | Minutes 22+ (advanced) | Fast-finishers / extension work |

---

## Audio Files You Need

Place all audio files in `game/audio/`. The examples reference these filenames —
rename your files to match, or update the filenames in the `.rpy` files.

| Filename | Type | Mood | Free Source |
|----------|------|------|-------------|
| `theme.mp3` | Music loop | Neutral / gentle | incompetech.com |
| `cozy_interior.mp3` | Music loop | Warm, safe | freemusicarchive.org |
| `tense_strings.mp3` | Music loop | Dark, tense | freemusicarchive.org |
| `mystery_ambient.mp3` | Music loop | Eerie, unsettled | pixabay.com/music |
| `thunder.wav` | SFX | Single thunder crack | freesound.org |
| `phone_buzz.wav` | SFX | Phone vibration | freesound.org |
| `kettle_whistle.wav` | SFX | Kettle steam | freesound.org |
| `wind_ambience.wav` | SFX | Outdoor wind | freesound.org |
| `footsteps_fast.wav` | SFX | Running footsteps | freesound.org |
| `car_alarm.wav` | SFX | Car alarm | freesound.org |
| `door_slam.wav` | SFX | Door closing hard | freesound.org |

**Minimum needed for class:** `theme.mp3` + one contrasting track for the Mood Experiment.

---

## Quick Command Reference (for posting in classroom)

```renpy
# Play background music (loops automatically)
play music "audio/filename.mp3"

# Play music with smooth fade-in
play music "audio/filename.mp3" fadein 2.0

# Play a one-shot sound effect
play sound "audio/filename.wav"

# Stop music smoothly
stop music fadeout 2.0

# Queue next track (plays when current one ends)
queue music "audio/filename.mp3"

# Change volume temporarily (0.0 = silent, 1.0 = full)
set music volume 0.3 delay 0.5
set music volume 1.0 delay 1.0
```

---

## Common Student Errors

| Error | Most Likely Cause | Fix |
|-------|------------------|-----|
| `Could not find audio file` | Wrong folder or wrong filename | Check `game/audio/` — filenames are case-sensitive |
| No sound, no error | Volume off in Ren'Py Preferences | Menu → Preferences → Music Volume |
| Music cuts abruptly | Used `stop music` without `fadeout` | Add `fadeout 2.0` |
| Music overlaps between scenes | Forgot to `stop music` before scene change | Always stop before jumping |
| Music plays but choppy | File format issue | Convert to .mp3 or .ogg |

---

## File Formats

- **Music:** `.mp3` or `.ogg` — both loop cleanly in Ren'Py
- **Sound effects:** `.wav` or `.ogg` — `.wav` is simplest for beginners
- **Avoid:** `.m4a`, `.aac`, `.flac` — may not work on all systems

---

## Attribution

If students use Kevin MacLeod music from incompetech.com (free with Creative Commons license),
remind them to credit: *"Music by Kevin MacLeod (incompetech.com), Licensed under CC BY 4.0"*

This is a real-world lesson in intellectual property and giving credit — worth a brief mention!
