#! /bin/bash

set -u  # terminate when accessing uninitialized variable
set -e  # terminate with error

DIR=$(dirname $(which drracket))
DEST="$DIR/mrracket"
wget -O "$DEST" https://raw.githubusercontent.com/bugcounting/mrracket/master/mrracket
chmod u+x "$DEST"
echo "$0: installation of mrracket in $DIR successful."
exit 0
