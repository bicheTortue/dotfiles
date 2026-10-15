#!/usr/bin/env python3
import sys
import colorsys
from collections import Counter
from PIL import Image

image = Image.open(sys.argv[1]).convert("RGB")
image.thumbnail((100, 100))

# Prefer saturated pixels so dark backgrounds don't dominate.
pixels = []
for r, g, b in image.getdata():
    h, s, v = colorsys.rgb_to_hsv(r / 255, g / 255, b / 255)
    if s > 0.20 and v > 0.15:
        pixels.append((h, s, v))

if not pixels:
    print("slate")
    sys.exit()

# Find the most common hue family among saturated pixels.
families = {
    "red": 0, "orange": 30, "yellow": 55,
    "green": 115, "teal": 165, "blue": 220,
    "purple": 275, "pink": 325,
}

def hue_distance(a, b):
    return min(abs(a - b), 360 - abs(a - b))

votes = Counter()
for h, s, v in pixels:
    degrees = h * 360
    nearest = min(families, key=lambda c: hue_distance(degrees, families[c]))
    votes[nearest] += s * v

print(votes.most_common(1)[0][0] if votes else "slate")
