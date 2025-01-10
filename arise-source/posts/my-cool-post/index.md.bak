<!-- BEGIN ARISE ------------------------------
Title:: "My Cool Post"

Author:: "Spectra Secure"
Description:: "This cool post is an example of a post published in Arise"
Language:: "en"
Thumbnail:: "kanagawa.jpg"
Published Date:: "2022-09-17"
Modified Date:: "2022-09-17"

---- END ARISE \\ DO NOT MODIFY THIS LINE ---->

# Look, a cool post

You can make cool posts on your Arise website!

You can even use images, look:

![The Great Wave off Kanagawa](kanagawa.jpg)




snfkashfsdf safsafhjsafd asfjsahfakjsdfas dfaskjdfhaskjdfasdf
asfjkhsajkfdhssnfkashfsdf safsafhjsafd asfjsahfakjsdfas
dfaskjdfhaskjdfasdf asfjkhsajkfdhssnfkashfsdf safsafhjsafd
asfjsahfakjsdfas dfaskjdfhaskjdfasdf asfjkhsajkfdhssnfkashfsdf
safsafhjsafd asfjsahfakjsdfas dfaskjdfhaskjdfasdf
asfjkhsajkfdhssnfkashfsdf `cd ~` safsafhjsafd asfjsahfakjsdfas
dfaskjdfhaskjdfasdf `bash youscript.sh` asfjkhsajkfdhssnfkashfsdf
safsafhjsafd asfjsahfakjsdfas dfaskjdfhaskjdfasdf
asfjkhsajkfdhssnfkashfsdf safsafhjsafd asfjsahfakjsdfas
dfaskjdfhaskjdfasdf asfjkhsajkfdhs

```bash
cd;

while (($#)); do
	shift;
done;


cd "$SCRIPT_DIR"


# Set the site config directories. Don't touch this-- changing the config location is not supported at this time
config="arise-out/config"
source arise-source/config/arise.conf

# Check if we're running a current version of bash before potentially causing code that won't run properly on ancient bash versions
if [ "$BASH_VERSINFO" -lt 5 ]; then
	cat <<ERROR >&2
ERROR: Arise requires Bash version 5 or greater to run. Please install
a newer version of Bash or ensure that you are using the newest
version installed on your computer.

Your current version of Bash is: $BASH_VERSINFO

You can verify the current running version of Bash by running the
following command: echo "\$BASH_VERSINFO"

ERROR
	exit 1
fi

# Makes sure that our paths have or don't have a '/' as expected regardless of user input.
## Favicon should have a '/' at the start of the path.
[[ $favicon != '' ]] && [[ ${favicon:0:1} != '/' ]] && favicon='/'"$favicon"
## Base URL should not have a '/' at the end.
[[ ${base_url: -1} == '/' ]] && base_url=${base_url::-1}

# Source functions
for FILE in lib/functions/{subshell,inline}/*.sh; do
	source "$FILE"
done




# Display our pretty logo no matter what when the program is run :)
arise_logo

# Set default build settings
force_overwrite=0
keep_source=0

build_pages=0
build_sitemap=0
build_rss=0


# first pass to separate options (-asdf becomes -a -s -d -f)
trailing_args=()
while (($#)); do
	arg=$1
	shift
	case "$arg" in
		(--?*)
			trailing_args+=("$arg")
			;;
		(--)
			trailing_args+=(--)
			break
			;;
		(-*)
			for letter in $(echo "${arg#-}" | grep -o .); do
				trailing_args+=("-$letter")
			done
			;;
		(*)
			trailing_args+=("$arg")
			;;
	esac
done
set -- "${trailing_args[@]}" "$@"

trailing_args=()
while (($#)); do
	arg="$1"
	shift
	case "$arg" in
		(-h|--help)
			arise_help
			exit 0
			;;
		(-p|--pages)
			build_pages=1
			;;
		(-s|--sitemap)
			build_sitemap=1
			;;
		(-r|--rss)
			build_rss=1
			;;
		(-f|--force)
			force_overwrite=1
			;;
		(-k|--keep-source)
			keep_source=1
			;;
		(--)
			break
			;;
		(-*)
			echo "Unknown option: $arg" >&2
			exit 1
			;;
		(*)
			trailing_args+=("$arg")
			;;
	esac
done
set -- "${trailing_args[@]}" "$@"



```

snfkashfsdf safsafhjsafd asfjsahfakjsdfas dfaskjdfhaskjdfasdf
asfjkhsajkfdhssnfkashfsdf safsafhjsafd asfjsahfakjsdfas
dfaskjdfhaskjdfasdf asfjkhsajkfdhssnfkashfsdf safsafhjsafd
asfjsahfakjsdfas dfaskjdfhaskjdfasdf asfjkhsajkfdhssnfkashfsdf
safsafhjsafd asfjsahfakjsdfas dfaskjdfhaskjdfasdf
asfjkhsajkfdhssnfkashfsdf safsafhjsafd asfjsahfakjsdfas
dfaskjdfhaskjdfasdf asfjkhsajkfdhssnfkashfsdf safsafhjsafd
asfjsahfakjsdfas dfaskjdfhaskjdfasdf asfjkhsajkfdhssnfkashfsdf
safsafhjsafd asfjsahfakjsdfas dfaskjdfhaskjdfasdf asfjkhsajkfdhs



snfkashfsdf safsafhjsafd asfjsahfakjsdfas dfaskjdfhaskjdfasdf
asfjkhsajkfdhssnfkashfsdf safsafhjsafd asfjsahfakjsdfas
dfaskjdfhaskjdfasdf asfjkhsajkfdhssnfkashfsdf safsafhjsafd
asfjsahfakjsdfas dfaskjdfhaskjdfasdf asfjkhsajkfdhssnfkashfsdf
safsafhjsafd asfjsahfakjsdfas dfaskjdfhaskjdfasdf
asfjkhsajkfdhssnfkashfsdf safsafhjsafd asfjsahfakjsdfas
dfaskjdfhaskjdfasdf asfjkhsajkfdhssnfkashfsdf safsafhjsafd
asfjsahfakjsdfas dfaskjdfhaskjdfasdf asfjkhsajkfdhssnfkashfsdf
safsafhjsafd asfjsahfakjsdfas dfaskjdfhaskjdfasdf asfjkhsajkfdhs

snfkashfsdf safsafhjsafd asfjsahfakjsdfas dfaskjdfhaskjdfasdf
asfjkhsajkfdhssnfkashfsdf safsafhjsafd asfjsahfakjsdfas
dfaskjdfhaskjdfasdf asfjkhsajkfdhssnfkashfsdf safsafhjsafd
asfjsahfakjsdfas dfaskjdfhaskjdfasdf asfjkhsajkfdhssnfkashfsdf
safsafhjsafd asfjsahfakjsdfas dfaskjdfhaskjdfasdf
asfjkhsajkfdhssnfkashfsdf safsafhjsafd asfjsahfakjsdfas
dfaskjdfhaskjdfasdf asfjkhsajkfdhssnfkashfsdf safsafhjsafd
asfjsahfakjsdfas dfaskjdfhaskjdfasdf asfjkhsajkfdhssnfkashfsdf
safsafhjsafd asfjsahfakjsdfas dfaskjdfhaskjdfasdf asfjkhsajkfdhs



