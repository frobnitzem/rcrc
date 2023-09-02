# User environment setup for [rc](https://github.com/frobnitzem/rc)

Documentation for rc is [here](http://doc.cat-v.org/plan_9/4th_edition/papers/rc)

There's a plethora of useful things here:

- rcrc - start-up script adding a nice prompt, pushd,popd,activate,deactivate
  activate and deactivate maintain a stack of `VIRTUAL_ENV`
  variables like pushd and popd.  Internally, all the implementations use
  rc lists (`path_history` and `venv_history`, respectively).

    cp rcrc $HOME/.rcrc

- vim/ - vim plugins to recognize rc scripts

    mkdir -p $HOME/.vim/ftdetect
    cp vim/ftdetect/rcshell.vim $HOME/.vim/ftdetect
    mkdir -p $HOME/.vim/syntax
    cp vim/syntax/rcshell.vim $HOME/.vim/syntax


- bin/* - various useful scripts

    mkdir $HOME/bin
    path = ($path $HOME/bin)
    cp bin/* $HOME/bin/

# The Revenge of Plan9

The push toward reliable containerization technology has made
modern Linux able to provide many of the key features of Plan9.

Note especially the following projects:

- https://github.com/containers/fuse-overlayfs

  Which makes it possible to mount a user-defined filesystem
  that binds multiple paths together.  Using this, it's possible
  to do things like merge /usr onto $HOME/local -- so that
  $HOME/local acts like /usr, but has user-additions.

- https://github.com/containers/bubblewrap

  This is a user-space sandbox that replaces / with a set of
  user-defined directories.

  For more context on what bubblewrap is doing, see
  [Michael Kerrisk's LWN tutorial](https://lwn.net/Articles/532593/).

- https://pkg.go.dev/github.com/frobnitzem/go-p9p

  This provides a high-level way to create your own sever application
  that responds to 9P2000 file operations.

- https://github.com/mischief/9pfs

  This is one of the best fuse filesystems for mounting 9P2000 filesystems.
  It seems to have fallen out of maintainence - likely because FUSE has
  put on several version evolutions since 9pfs was written.
  Also, I remember fixing a bug in its directory caching mechanism
  somewhere, and need to upload that back to github.

- [additional libraries](https://9p.cat-v.org/implementations)
