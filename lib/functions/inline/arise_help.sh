#!/bin/bash
#############                                                                                            
# DESCRIPTION
#############
# Prints help
#
#############
# Usage:
# arise_help

arise_help() {
	echo "Version $arise_version"

	cat <<"HELP"
NAME

	arise, a static site generator written in Bash

SYNOPSIS

	arise build [<options>]...

DESCRIPTION

	Arise copies the "arise-source" directory into "arise-out", then
	processes recursively the "arise-out" directory, converting
	"index.md" files into html files, following documented behavior.
	As a result, Arise is a static site generator.

OPTIONS

	Options Relating to the Build

		*Note that providing none of the following three options is
		 equivalent to providing all three.

		-p, --pages

			Generate the html pages.

		-s, --sitemap

			Generate the site map.

		-r, --rss

			Generate the rss feed.

	Other Options

		-h, --help

			Print this help message.

		-f, --force

			Overwrite the previous arise-out folder.

		-k, --keep-source

			After the build, do not remove source files from the
			arise-out folder.

HELP
	
}
