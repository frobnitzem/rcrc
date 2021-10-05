# profile for [rc](https://github.com/benavento/rc)

Documentation for rc is [here](http://doc.cat-v.org/plan_9/4th_edition/papers/rc)

```bash
# $home/.rcrc
ps1 = '% '
tab = '    '
fn cd {
  builtin cd $* &&
  switch($#*){
  case 0
    prompt=($ps1 $tab)
  case *
    switch($1){
    case /*
      prompt=(`{basename `{pwd}}^$ps1 $tab)
    case */* ..*
      prompt=(`{basename `{pwd}}^$ps1 $tab)
    case *
      prompt=($1^$ps1 $tab)
    }
  }
}

# shift the named variable left by 1
fn shift_var {
    var=$1
    *=$$var
    shift
    $var=$*
}
fn pushd {
    path_history = (`{pwd} $path_history)
    cd $1
    echo `{pwd} $path_history
}
fn popd {
    if(~ $#path_history 0)
      echo 'popd: directory stack empty'
    if not {
      cd $path_history(1)
      shift_var path_history
    }
    echo `{pwd} $path_history
}
```
