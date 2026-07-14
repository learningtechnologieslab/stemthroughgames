# ============================================================
#  STEM THROUGH GAMES — Introduction to RenPy
#  Example 1: Hello, World!
#  Concept: Your very first RenPy script
# ============================================================
#
#  WHAT THIS TEACHES:
#    - Every RenPy game starts with a "label start:"
#    - The "say" command displays text on screen
#    - Quotation marks hold the words a character speaks
#    - "return" ends the game (or a scene)
#
#  HOW TO RUN:
#    1. Open the RenPy launcher
#    2. Create a new project called "HelloWorld"
#    3. Replace the contents of script.rpy with this file
#    4. Click "Launch Project"
# ============================================================

# All RenPy games begin at "label start"
label start:

    # This line displays a message with no speaker
    "Hello, world! Welcome to my first visual novel."

    # A pause, then another line
    "This is what a visual novel looks like behind the scenes."

    "Pretty simple, right? Just words in quotes."

    # "return" tells RenPy the story is over
    return
