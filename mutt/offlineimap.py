#!/usr/bin/python
import subprocess


def get_mailpw(account=None):
    output = subprocess.check_output("gpg2 -dq ~/.mailpw.gpg",
                                     shell=True,
                                     stderr=subprocess.STDOUT)
    passwd = ''
    for l in output.splitlines():
        (user, passwd) = l.split('\t')
        if user == account:
            break
    return passwd
