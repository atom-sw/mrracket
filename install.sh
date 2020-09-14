#! /bin/bash

set -u  # terminate when accessing uninitialized variable
set -e  # terminate with error

VERSION="7.8"
INSTALLER="racket-$VERSION-x86_64-linux.sh"
DESTINATION="$HOME/racket/bin"

wget "https://mirror.racket-lang.org/installers/$VERSION/$INSTALLER"
chmod u+x "$INSTALLER"
echo "Running DrRacket installer. When prompted with requests, type: Enter, then 3, then Enter."
echo "no
3
" | bash "./$INSTALLER"
echo "export PATH=\$PATH:$DESTINATION" >> "$HOME/.bashrc"

wget -O "$DESTINATION/mrracket" https://raw.githubusercontent.com/bugcounting/mrracket/master/mrracket
chmod u+x "$DESTINATION/mrracket"

echo "$0: installation of DrRacket in $DESTINATION successful. Exit this shell now."
