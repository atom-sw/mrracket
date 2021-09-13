#! /bin/bash

set -u  # terminate when accessing uninitialized variable
set -e  # terminate with error

VERSION="8.2"
INSTALLER="racket-$VERSION-x86_64-linux.sh"
INSTALLDIR="$HOME/racket"
DESTINATION="$INSTALLDIR/bin"

wget "https://mirror.racket-lang.org/installers/$VERSION/$INSTALLER"
chmod u+x "$INSTALLER"
echo "Running DrRacket installer into $INSTALLDIR."
echo "no
3
" | bash "./$INSTALLER"

# download logo
wget -O "$INSTALLDIR/racket-logo.svg" https://racket-lang.org/img/racket-logo.svg

# add to path
echo 'export PATH=$PATH:'"$DESTINATION" >> "$HOME/.bashrc"

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
" > "$HOME/Desktop/DrRacket.desktop"
chmod u+x "$HOME/Desktop/DrRacket.desktop"

wget -O "$DESTINATION/mrracket" https://raw.githubusercontent.com/bugcounting/mrracket/master/mrracket
chmod u+x "$DESTINATION/mrracket"

echo "$0: installation of DrRacket in $DESTINATION successful. Exit this terminal now."
