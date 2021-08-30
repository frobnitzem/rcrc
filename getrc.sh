#!/bin/bash
# A shell script to get rc and add it to your path.

set -e

# Will look for rc in $PREFIX/bin and install if not present.
# Also adds $PREFIX/bin to path and $PREFIX/share/man to MANPATH.
PREFIX=$HOME
if [ $# -eq 1 ]; then
    PREFIX="$1"
fi

get_rc() {
  dir="`mktemp -d`"
  cwd="`pwd`"
  cd "$dir"
    git clone https://github.com/benavento/rc
    cd rc
    mkdir -p "$PREFIX/bin"
    mkdir -p "$PREFIX/lib"
    mkdir -p "$PREFIX/share/man/man1"
    make -j4 install PREFIX="$PREFIX"
  cd "$cwd"
  rm -fr "$dir"
}

# test for functioning rc
test_rc() {
  rc -c 'echo success' 2>/dev/null | grep -q success
}

if ! test_rc; then
  if ! grep -q "$PREFIX/bin" <<<"$PATH"; then
    PATH="$PATH:$PREFIX/bin"
  fi
  if ! grep -q "$PREFIX/share/man" <<<"$MANPATH"; then
    MANPATH="$MANPATH:$PREFIX/share/man"
  fi
  if ! [ -x "$PREFIX/bin/rc" ]; then
      echo "Installing rc into $PREFIX/bin"
      get_rc
  fi
fi
