#!/bin/bash

# Fingerprint for some container tech

# TODO: Handle args
CF_GARDEN=0
LXD=0
FIND_RES=0
SEARCH_FOR_ALL=1
if [[ $SEARCH_FOR_ALL ]]; then
	$(find "/" 2>&1 | grep -E "docker|garden")
fi
