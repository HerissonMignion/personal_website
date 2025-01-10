# Running Arise Locally

The following instructions will walk you through how to build an Arise website by running Arise on your local machine. This is primarily intended for development and not regular use. If you just want to throw up an Arise website as easily as possible, please use the cloud native instructions in the [Getting Started](../getting-started/README.md) guide.

1. Ensure you have the [proper dependencies](/README.md#dependencies) installed.
2. Clone this repo and cd into it: `git clone https://github.com/spectrasecure/arise && cd arise`.
3. Edit the global Arise site configuration file at `/arise-source/config/arise.conf`.
4. Edit the example site in `/arise-source/` to your liking.
    - Check out the page on [creating pages](../creating-arise-pages/README.md) for more information on the specifics of how Arise pages work.
5. Configure your `robots.txt` in the root of the repository with your site domain and any additional crawler settings you'd like to set.
6. Build Arise by running `bash arise build`.
7. Your built site will be outputted to `arise-out/`. It is up to you to upload this to the static folder (/var/www/html) of your web server.

### Command Line Arguments for Arise

The Arise shell script acts like a usual "binary" / command. It allows for several partial build modes, largely for testing purposes. These options are also displayed to you in the Help prompt which is displayed when you attempt to run Arise without any options.

```
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
```

- `bash arise build -p` - Running Arise in this manner will only build (p)ages. It will not build the sitemap or the RSS feed.
- `bash arise build -s` - Running Arise in this manner will only build the (s)itemap. It won't build anything else.
- `bash arise build -r` - Running Arise in this manner will only build the (r)ss feed. It won't build anything else.
- `-k` - Adding this flag to any build mode will (k)eep the source files in the output directory rather than deleting them from the output.
- `-f` - By default, Arise will throw an error when the output folder `arise-out` already has contents in it in order to prevent you from accidentally overwriting your previous build output. If you would like to override this safeguard and (f)orce Arise to delete the contents of `arise-out`, this is the flag to do so.
