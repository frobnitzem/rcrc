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
