#!/usr/bin/python
from datetime import datetime
import os
import time

day_wp_path = "$HOME/Pictures/eltsin_ghibli_wp.png"
night_wp_path = "$HOME/Pictures/gentoo_space_wp.png"

mode = None
while True:
    hour = datetime.now().hour
    if 6 <= hour < 22 and (mode is None or mode == 'night'):
        mode = 'day'
        os.system(f"feh --bg-scale {day_wp_path}")
    elif (hour < 6 or hour >= 22) and (mode is None or mode == 'day'):
        mode = 'night'
        os.system(f"feh --bg-scale {night_wp_path}")
    time.sleep(1)

