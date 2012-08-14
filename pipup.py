#!/usr/bin/env python
# Check if a newer version of installed packages are available on PyPI.
# Author: Artur Siekielski
# Source: http://code.activestate.com/recipes/577708-check-for-package-updates-on-pypi-works-best-in-pi/
# License: MIT (http://opensource.org/licenses/mit-license.php/)

import xmlrpclib
import pip

pypi = xmlrpclib.ServerProxy('http://pypi.python.org/pypi')
for dist in pip.get_installed_distributions():
    available = pypi.package_releases(dist.project_name)
    if not available:
        # Try to capitalize pkg name
        available = pypi.package_releases(dist.project_name.capitalize())
        
    if not available:
        msg = 'no releases at pypi'
    elif available[0] != dist.version:
        msg = '{} available'.format(available[0])
    else:
        msg = 'up to date'
    pkg_info = '{dist.project_name} {dist.version}'.format(dist=dist)
    print '{pkg_info:40} {msg}'.format(pkg_info=pkg_info, msg=msg)
