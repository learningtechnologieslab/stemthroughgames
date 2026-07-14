IMAGES FOLDER — README
Day 6: Backgrounds & Visual Storytelling
STEM through Games — Middle School RenPy Unit

====================================================================
RIGHT NOW: The scripts use color fills instead of real image files.
This means everything runs without you needing any PNG files yet.
====================================================================


HOW TO ADD REAL BACKGROUND IMAGES
-----------------------------------
1. Find or create a background image (PNG or JPG format works best)

2. Save it into THIS folder:
     renpy_examples/game/images/

3. Name it something simple with no spaces:
     classroom.png
     hallway.png
     park_day.png
     stormy_street.png

4. In script.rpy, find the placeholder image definitions at the top:
     image classroom = Solid("#D4E8F0")

   Replace that line with NOTHING — just delete it.
   RenPy will automatically find classroom.png in this folder.

5. Your scene commands stay exactly the same:
     scene classroom with dissolve


RECOMMENDED IMAGE SIZE
------------------------
  1280 x 720 pixels  (standard for 16:9 games)
  or
  1920 x 1080 pixels (higher quality)

  Save as PNG for best quality.
  JPG works too but can look blurry at transitions.


WHERE TO FIND FREE BACKGROUND ART
------------------------------------
  - Itch.io (search "visual novel backgrounds free")
    https://itch.io/game-assets/tag-visual-novel/free

  - OpenGameArt.org
    https://opengameart.org

  - Make your own with Piskel (pixel art, free in browser)
    https://www.piskelapp.com

  - AI image generators (with teacher permission)


RECOMMENDED BACKGROUNDS FOR THIS PROJECT
------------------------------------------
  classroom.png       — a school classroom, daytime
  hallway.png         — a school hallway, dim or empty
  cafeteria.png       — a school cafeteria
  park_day.png        — outdoor park, daytime, bright
  park_night.png      — same park but at night / dusk
  library.png         — a library or study space
  storm.png           — stormy sky, rain, dark clouds


TIPS
------
  - Avoid backgrounds with people in them — your characters
    will appear to float in front of crowds!

  - Backgrounds with a clear "floor line" look best with characters.

  - You can use the SAME background art at different times by
    adjusting your story's color theme with im.MatrixColor or
    just keeping separate light/dark versions of the image.
