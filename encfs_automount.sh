#!/bin/bash
#
# Mount one or more EncFS volumes using passphrases that have been encrypted
# with GnuPG.
#
# I have multiple EncFS volumes that need to be mounted as soon as I login.
# Each volume has a different passphrase. I don't want to have to type each
# passphrase every time I login. I also don't want to store the passphrases in
# clear-text on the machine (doing so would defeat the purpose of encrypting
# the volumes).
#
# My solution is to create a text file that holds a single EncFS passphrase. 
# This is done for every EncFS passphrase, and each file is then individually
# encrypted with GnuPG. This script then decrypts each EncFS passphrase file
# and mounts the EncFS volumes. Because gpg-agent(1) remembers the GnuPG
# passphrase, it only needs to be entered once. This works for both symmetric
# and asymmetric encryption.
#
# Author:   Pig Monkey (pm@pig-monkey.com)
# Website:  https://github.com/pigmonkey/systools
#
###############################################################################

# Create an array to hold the EncFS volumes.
VOLUMES=( VOLUME1 VOLUME2 VOLUME3 )

# Define the EncFS volumes to be mounted. Each array should consist of strings
# specifying, in order, the location of the encrypted volume, the mount
# location, and the GnuPG-encrypted text file holding the passphrase.
# For example:
# VOLUME1=( "/my/encrypted/dir" "/my/decrypted/dir" "/file/with/passphrase.gpg" )
VOLUME1=( "$HOME/test/vault" "$HOME/test/decrypt" "$HOME/test/mypass.txt.gpg" )

# Specify the location of the EncFS binary. You may also specify additional
# options to pass to EncFS.
# For example:
# ECNFS="/usr/bin/encfs -o allow_other"
ENCFS="/usr/bin/encfs"

# Specify the location of the GnuPG binary.
GPG="/usr/bin/gpg"

# End configuration here.
###############################################################################

for i in "${VOLUMES[@]}"
do

    # Establish the needed variables from the array.
    root=$(eval echo \${$i[0]})
    mount=$(eval echo \${$i[1]})
    passfile=$(eval echo \${$i[2]})

    # Proceed only if the file that holds the passphrase is not zero and the
    # EncFS root directory exists.
    if [ -s "$passfile" -a -d "$root" ]; then
        # Decrypt the EncFS passphrase.
        passphrase=$($GPG --batch -q -d $passfile)
        # If the EncFS mount point does not exist, create it.
        if [ ! -d "$mount" ]; then
            mkdir $mount
        fi
        # Mount the EncFS filesystem.
        echo $passphrase | $ENCFS --stdinpass $root $mount
    fi

done
