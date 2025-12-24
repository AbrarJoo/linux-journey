#!/bin/bash

#used for debugging pipes in bash

used to check pipe errors for example

cat heyy | tr . :

the first one gives error and the last doesnt
so echo $? will give 0 meaning no error

so to get accurate pipe satatus use

echo "{$PIPESTATUS}" AFTER RUNNING THE SCRIPT
