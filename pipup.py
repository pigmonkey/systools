#!/usr/bin/env python
# Check if a newer version of installed packages are available on PyPI.
# Author: Artur Siekielski
# Source: http://code.activestate.com/recipes/577708-check-for-package-updates-on-pypi-works-best-in-pi/
# License: MIT (http://opensource.org/licenses/mit-license.php/)

import xmlrpclib
import pip
import argparse
import subprocess

# Set arguments.
parser = argparse.ArgumentParser(description='Check if a newer version of \
                                              installed packages are \
                                              available on PyPI.')
parser.add_argument('-q', '--quiet', action='store_true',
                    help='Only output packages with available upgrades.')
parser.add_argument('-u', '--upgrade', action='store_true',
                    help='Run any available upgrades.')

# Parse arguments.
args = parser.parse_args()

upgrades = []

pypi = xmlrpclib.ServerProxy('http://pypi.python.org/pypi')
for dist in pip.get_installed_distributions():
    available = pypi.package_releases(dist.project_name)
    if not available:
        # Try to capitalize pkg name
        available = pypi.package_releases(dist.project_name.capitalize())

    if not available:
        if args.quiet:
            continue
        else:
            msg = 'no releases at pypi'
        
    elif available[0] != dist.version:
        msg = '{} available'.format(available[0])
        upgrades.append(dist)
    else:
        if args.quiet:
            continue
        else:
            msg = 'up to date'
    pkg_info = '{dist.project_name} {dist.version}'.format(dist=dist)
    print '{pkg_info:40} {msg}'.format(pkg_info=pkg_info, msg=msg)

if args.upgrade and upgrades:
    for package in upgrades:
        print 'Upgrading %s' % (package.project_name)
        try:
            process = subprocess.call(['pip', 'install', '--upgrade',
                                       package.project_name])
        except OSError:
            print 'Could not find pip'
        except subprocess.CalledProcessError:
            print 'pip returned non-zero status'
