# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

from __future__ import (absolute_import, division, print_function)

# You can import any python module as needed.
import os

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command


# Any class that is a subclass of "Command" will be integrated into ranger as a
# command.  Try typing ":my_edit<ENTER>" in ranger!
import subprocess

class mount_usb(Command):
    """
    :mount_usb

    Mount first unmounted external drive.
    """
    def execute(self):
        try:
            mp = subprocess.check_output(
                ["/home/ultragreed/.local/scripts/mount-usb.sh"],
                text=True,
            ).strip()
            self.fm.notify("USB device mounted")
        except subprocess.CalledProcessError:
            self.fm.notify("No unmounted removable devices found", bad=True)
            return

        if mp:
            self.fm.cd(mp)
        else:
            self.fm.notify("Failed to mount USB device", bad=True)


class umount_usb(Command):
    """
    :umount_usb

    Umount external drive mounted in current directory.
    """
    def execute(self):
        mpath = self.fm.thisdir.path

        self.fm.cd('~')

        try:
            result = subprocess.check_output(
                ["/home/ultragreed/.local/scripts/umount-usb.sh", mpath],
                cwd='/',
                text=False,
            )
            self.fm.notify(f"USB device for {mpath} unmounted")
        except subprocess.CalledProcessError:
            self.fm.cd(mpath)
            self.fm.notify("Failed to unmount USB device: device is busy or no device mounted in dir", bad=True)

