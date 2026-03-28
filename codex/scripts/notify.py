
import json
import subprocess
import sys
import random
import os

messages = [
        "Turn complete",
        "You are absilutely right!"
        ]

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
    num = random.randint(0, 10)
    if num < 9:
        message = messages[0]
    else:
        message = messages[1]
    subprocess.run(["say", message], check=False)
    return 0


if __name__ == "__main__":
    sys.exit(main())
