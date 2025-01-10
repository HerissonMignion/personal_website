#!/bin/bash
#############                                                                                            
# DESCRIPTION
#############
# Builds all pages on the site by calling "build_page" for every markdown file it can find outside of /config.
#
# Note that this function actually takes the root site directory to recursively build from as an argument.
#
#############
# Usage:
# build_page /path/to/arise-out/

build_page_tree() (
	cd "$1"

	find . -type f -name "index.md" -not \( -path ./config -prune \) -print0 | \
		while read -r -d $'\0' fname; do
			build_page "$fname"

			# Add the source file to the list of files to remove in cleanup
			echo "$(realpath "$fname")" >> "$removelist"
		done
)
