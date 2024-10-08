#!/bin/bash
# This script sets up environment for running the rc shell.
# After it completes, start a login with "rc -l"

# Will look for rc in $PREFIX/bin and install if not present.
# Also sets 
PREFIX="$HOME"
if [ $# -eq 1 ]; then
    PREFIX="$1"
fi

get_rc() {
    dir="`mktemp -d`"
    cwd="`pwd`"
    cd "$dir"
	    git clone https://github.com/frobnitzem/rc && \
	    cd rc && \
	    mkdir -p "$PREFIX/bin" && \
	    mkdir -p "$PREFIX/lib" && \
	    mkdir -p "$PREFIX/share/man/man1" && \
	    make -j4 install PREFIX="$PREFIX"
    ret=$?
    cd "$cwd"
    rm -fr "$dir"
    return $ret
}

get_readline_then_rc() {
    dir="`mktemp -d`"
    cwd="`pwd`"
    cd "$dir"
        wget ftp://ftp.gnu.org/gnu/readline/readline-8.2.tar.gz && \
        tar xzf readline-8.2.tar.gz && \
        cd readline-8.2/ && \
        ./configure --prefix="$PREFIX" && \
        make -j install && \
        cd .. && \
	    git clone https://github.com/frobnitzem/rc && \
	    cd rc && \
	    mkdir -p "$PREFIX/bin" && \
	    mkdir -p "$PREFIX/lib" && \
	    mkdir -p "$PREFIX/share/man/man1" && \
	    make -j4 install PREFIX="$PREFIX" CFLAGS='-I$(PREFIX)/include' LFLAGS'-lreadline -ltinfo -L$(PREFIX)/lib -Wl,-rpath,$(PREFIX)/lib'
    ret=$?
    cd "$cwd"
    rm -fr "$dir"
    return $ret
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
      get_rc || get_readline_then_rc || {
          echo "Installing rc failed."
          echo "This is usually a problem with readline..."
          echo "try: make install -j4 PREFIX=\"$PREFIX\" CFLAGS='-I$(PREFIX)' LFLAGS='-L$(PREFIX)/lib -Wl,-rpath,$(PREFIX)/lib -lreadline -lcurses'"
      }
  fi
fi
