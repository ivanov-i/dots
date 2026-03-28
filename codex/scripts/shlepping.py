
import json
import subprocess
import sys
import random
import os

messages = """
        Accomplishing, Actioning, Actualizing, Baking, Booping, Brewing,
Calculating, Cerebrating, Channelling, Churning, Clauding,
Coalescing, Cogitating, Combobulating, Computing, Concocting,
Considering, Contemplating, Cooking, Crafting, Creating,
Crunching, Deciphering, Deliberating, Determining,
Discombobulating, Divining, Doing, Effecting, Elucidating,
Enchanting, Envisioning, Finagling, Flibbertigibbeting,
Forging, Forming, Frolicking, Generating, Germinating,
Hatching, Herding, Honking, Hustling, Ideating, Imagining,
Incubating, Inferring, Jiving, Manifesting, Marinating,
Meandering, Moseying, Mulling, Mustering, Musing, Noodling,
Percolating, Perusing, Philosophising, Pondering,
Pontificating, Processing, Puttering, Puzzling, Reticulating,
Ruminating, Scheming, Schlepping, Shimmying, Shucking,
Simmering, Smooshing, Spelunking, Spinning, Stewing,
Sussing, Synthesizing, Thinking, Tinkering, Transmuting,
Unfurling, Unravelling, Vibing, Wandering, Whirring,
Wibbling, Wizarding, Working, Wrangling,
Flambéing, Gallivanting, Skedaddling, Zigzagging, Nebulizing, Moonwalking
"""

messages = [m.strip() for m in messages.split(",")]

#log file in ~/Downloads
# home = os.path.expanduser("~")
# logFilePath = os.path.join(home, "Downloads", "notify.log")
# logFile = open(logFilePath, "w")

def log(message: str) -> None:
    # logFile.write(message + "\n" + "-"*20 + "\n")
    pass

log ("Script started")

def main() -> int:
    # a random number between 0 and 10
    i = random.randint(0, len(messages)-1) 
    message = messages[i]
    subprocess.run(["say", message], check=False)
    output = """{"systemMessage": message}"""
    print(output) 
    return 0


if __name__ == "__main__":
    sys.exit(main())
