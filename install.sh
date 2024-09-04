#! /bin/bash

set -u  # terminate when accessing uninitialized variable
set -e  # terminate with error

VERSION="8.14"
INSTALLER="racket-$VERSION-x86_64-linux.sh"
INSTALLDIR="$HOME/racket"
DESTINATION="$INSTALLDIR/bin"


OVERWRITE=0
CONTINUE=0

print_usage ()
{
	 echo "
Install Racket and Dr. Racket on Ubuntu systems.

  Usage: $0 [-oc] [-d DIR] [-v VER]
    -o      if a Racket installation already exists, overwrite it
    -c      if a Racket installer file is found, do not download it again
    -d DIR  install Racket under DIR (default: $INSTALLDIR)
    -v VER  install Racket version VER (default: $VERSION)
"
}

while getopts ":ocd:v:" opt; do
	 case $opt in
		  o)
				OVERWRITE=1
				;;
		  c)
				CONTINUE=1
				;;
		  d)
				INSTALLDIR=$OPTARG
				;;
		  v)
				VERSION=$OPTARG
				;;
		  :)
				echo "Option: -$OPTARG requires an argument" >&2
				print_usage
				exit 1
				;;
		  \?)
				echo "Invalid option: -$OPTARG" >&2
				print_usage
				exit 1
				;;
	 esac
done

if [ -d "$INSTALLDIR" ]; then
	 echo "Installation directory $INSTALLDIR already exists."
	 if [ $OVERWRITE -eq 1 ]; then
		  echo "Removing the existing installation and installing anew."
		  read -p "Press Enter to continue or Ctrl-C to terminate."
		  rm -r "$INSTALLDIR"
	 else
		  echo "Run again with option -o to overwrite the existing installation."
		  echo "Nothing done."
		  exit 0
	 fi
else
	 echo "Installing DrRacket in directory $INSTALLDIR."
fi

if [ -f "$INSTALLER" ]; then
	 echo "The DrRacket installer is already downloaded."
	 if [ $CONTINUE -eq 1 ]; then
		  echo "Running the downloaded installer."
	 elif [ $OVERWRITE -eq 1 ]; then
		  read -p "Press ENTER to download the installer again, overwriting the existing one."
		  wget -O "$INSTALLER" "https://mirror.racket-lang.org/installers/$VERSION/$INSTALLER"
	 else
		  echo "Run again with option -c to use the downloaded installer, or use option -o to download again."
		  echo "Nothing done."
		  exit 0
	 fi
else
	 wget -O "$INSTALLER" "https://mirror.racket-lang.org/installers/$VERSION/$INSTALLER"
fi

chmod u+x "$INSTALLER"
echo "no
$INSTALLDIR
" | bash "./$INSTALLER"

# download logo
wget -O "$INSTALLDIR/racket-logo.svg" https://racket-lang.org/img/racket-logo.svg

# add to path
echo 'export PATH=$PATH:'"$DESTINATION" >> "$HOME/.bashrc"

# try to retrieve Desktop folder location from config
# so that it works also if Ubuntu is configured in a different language
X_DIRS="$HOME/.config/user-dirs.dirs"
if [ -f "$X_DIRS" ]; then
	 source "$X_DIRS"
	 DESKTOP="$XDG_DESKTOP_DIR"
else
	 # fallback: assume ~/Desktop is the desktop folder
	 DESKTOP="$HOME/Desktop"
fi

# add installer
echo "#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Exec=$DESTINATION/drracket
Name=DrRacket
Comment=DrRacket
Icon=$INSTALLDIR/racket-logo.svg
" > "$DESKTOP/DrRacket.desktop"
chmod u+x "$DESKTOP/DrRacket.desktop"

wget -O "$DESTINATION/mrracket" https://raw.githubusercontent.com/atom-sw/mrracket/master/mrracket
chmod u+x "$DESTINATION/mrracket"

echo "$0: installation of DrRacket in $DESTINATION successful. Exit this terminal now."
