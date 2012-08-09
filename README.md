Systools
========

These are miscellaneous helpers and system administration scripts.


encfs_automount.sh
------------------

A Bash script that mounts one or more [EncFS](http://www.arg0.net/encfs)
volumes using passphrases that have been encrypted with
[GnuPG](http://www.gnupg.org/).

I have multiple EncFS volumes that need to be mounted as soon as I login. Each
volume has a different passphrase. I don't want to have to type each passphrase
every time I login. I also don't want to store the passphrases in clear-text on
the machine (doing so would defeat the purpose of encrypting the volumes).

My solution is to create a text file that holds a single EncFS passphrase. This
is done for every EncFS passphrase, and each file is then individually
encrypted with GnuPG. This script then decrypts each EncFS passphrase file and
mounts the EncFS volumes. Because gpg-agent(1) remembers the GnuPG passphrase,
it only needs to be entered once. This works for both symmetric and asymmetric
encryption.


fehbrowser.sh
-------------

Open an image in [feh](http://feh.finalrewind.org/) while allowing all other
images in the directory to be viewed as well. Useful for file browsers.

Source: [https://wiki.archlinux.org/index.php/Feh#File_Browser_Image_Launcher]


memusage.py
-----------

A Python script to calculate total memory usage.

This script merely totals the memory used by each process reported by PS(1) for
the executing user and presents the result in a human-readable format.

It is useful for [WebFaction](http://www.webfaction.com/) users and those in a
similar environment.
