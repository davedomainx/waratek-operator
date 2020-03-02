#!/bin/bash

# Script to download a Waratek Product, extract and configure it.
# Assumption: waratek user and download link (signed URL) is valid.
# Note: Download links are customer specifc.

# Default signed url is for 'Waratek Demo Product'
SIGNED_URL=$1

readonly INSTALL_ROOT="/opt"
readonly INSTALL_SYMLINK="${INSTALL_ROOT}/waratek"

usage()
{
    echo "Usage: $0 <signedurl>"
    echo "e.g. $0 signedurl"
    exit 0
}

create_symlink()
{
    # Check if $2 is a symbolic link and if so, remove it
    [ -L $2 ] && rm -f $2

    # Create symlink between $1 and $2
    ln -s $1 $2
}

if [[ $# -ne 1 ]]; then
    echo "[WARNING] No download link for a Waratek product was specified."
    usage
fi

# Get artifact name from Signed URL
ARTIFACT=$(basename $(echo ${SIGNED_URL} | cut -d\? -f1))
PRODUCTDIR=$(basename ${ARTIFACT} .zip)

# Download the artifact
cd ${HOME}
wget -O ${ARTIFACT} ${SIGNED_URL}

# Check if download completed successfully
if [ $? -eq 0 ]
then
    echo "[INFO] Successfully downloaded file"
else
    echo "[ERROR] Unable to download the file from the signed URL"
    exit 1
fi

# Extract the artifact
unzip ${ARTIFACT} -d ${INSTALL_ROOT}

# Create symlink
create_symlink ${INSTALL_ROOT}/${PRODUCTDIR} ${INSTALL_SYMLINK}
