#! /usr/bin/env python2
from subprocess import check_output, call
import os

def get_pass(storeinfile='/tmp/offlineimap_ip_gm.tmp'):
    if not os.path.isfile(storeinfile):
        call('pass email/offlineimap/isprokin@gmail.com > {0} && chmod 600 {0}'.format(storeinfile), shell=True)
    #return check_output('pass email/offlineimap/isprokin@gmail.com', shell=True).strip('\n')
    return check_output('cat {}'.format(storeinfile), shell=True).strip('\n')

if __name__ == '__main__':
    get_pass()
