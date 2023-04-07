#!/usr/bin/env sed -f

/TODO/!d;
=;
s/.*TODO/----------------\nTODO/;
:loop
    n;
    s/.*\/\/ *//;
t loop
s/.*//;
