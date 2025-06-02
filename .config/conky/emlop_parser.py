#!/usr/bin/python

import subprocess

def format_time(seconds_total):
    seconds = seconds_total % 60

    minutes = seconds_total // 60

    hours = minutes // 60

    minutes %= 60

    return f'{str(hours).rjust(2, "0")}:{str(minutes).rjust(2, "0")}:{str(seconds).rjust(2, "0")}'

command = "emlop p -s t --duration secs"

emlop_anwer = subprocess.run(command, shell=True, executable='/bin/bash', stdout=subprocess.PIPE).stdout.decode()

if emlop_anwer != "No pretended merge found\n":
    words = emlop_anwer.split()

    seconds = words[-4]

    time_total = format_time(int(seconds))

    print(words[2], time_total)
