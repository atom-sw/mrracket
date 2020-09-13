#! /bin/bash

set -u  # terminate when accessing uninitialized variable
set -e  # terminate with error

DIR=$(dirname $(which drracket))
wget -O "$DIR" https://raw.githubusercontent.com/bugcounting/mrracket/master/mrracket
chmod u+x "$DIR/mrracket"
echo "$0: installation of mrracket in $DIR successful."
exit 0
