#!/usr/bin/python

import subprocess

def format_time(seconds_total):
    seconds = seconds_total % 60

    minutes = seconds_total // 60

    hours = minutes // 60

    minutes %= 60

    return f'{str(hours).rjust(2, "0")}:{str(minutes).rjust(2, "0")}:{str(seconds).rjust(2, "0")}'

command = "qlop -rtM"

qlop_anwer = subprocess.run(command, shell=True, executable='/bin/bash', stdout=subprocess.PIPE).stdout.decode()

if qlop_anwer != '\n':
    words = qlop_anwer.split()

    seconds_eta = words[-1]

    time_eta = format_time(int(seconds_eta)) if seconds_eta != 'unknown' else 'unknown'

    seconds_gone = words[3][:-3]

    time_gone = format_time(int(seconds_gone))

    seconds_total = int(seconds_eta) + int(seconds_gone) if seconds_eta != 'unknown' else 'unknown'

    time_total = format_time(seconds_total)

    result = f'CURRENT: {words[2][:-1]} \t THIS: {time_gone}/{time_total}'

    print(words[2][:-1], time_gone, time_eta)
