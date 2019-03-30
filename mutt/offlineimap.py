#!/usr/bin/python
import subprocess


def get_mailpw(account=None):
    output = subprocess.check_output("~/mail/getpass.sh",
                                     shell=True,
                                     stderr=2)
    return output.strip()
