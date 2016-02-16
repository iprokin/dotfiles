#! /usr/bin/env python2
from subprocess import check_output

def get_pass():
    return check_output('pass email/offlineimap/isprokin@gmail.com', shell=True).strip('\n')
