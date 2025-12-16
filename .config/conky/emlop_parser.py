#!/usr/bin/python

import subprocess

def format_time(seconds_total):
    seconds = seconds_total % 60

    minutes = seconds_total // 60

    hours = minutes // 60

    minutes %= 60

    return f'{str(hours).rjust(2, "0")}:{str(minutes).rjust(2, "0")}:{str(seconds).rjust(2, "0")}'


emlop_command = "emlop p -s t --duration secs --color no"
command = f"script -qc '{emlop_command}' /dev/null"  # emlop only works in TTY for some reason
                                                     # script emulates TTY run

command = "/home/ultragreed/Downloads/emlop/target/debug/emlop p -s t --duration secs"
emlop_answer = subprocess.run(command, shell=True, executable='/bin/bash', stdout=subprocess.PIPE).stdout.decode()
print(repr(emlop_answer))

if emlop_answer.startswith('Estimate for'):
    words = emlop_answer.split()

    seconds = words[-4]

    time_total = format_time(int(seconds))

    print(words[2], time_total)
