#!/bin/bash

/bin/bash -c "/usr/bin/boinc &"
sleep 10
/usr/bin/boinccmd --read_cc_config

if [ $ROSETTA_AT_HOME_ACCOUNT_KEY != "" ]; then
    /usr/bin/boinccmd --project_attach http://boinc.bakerlab.org/rosetta/ $ROSETTA_AT_HOME_ACCOUNT_KEY
    sleep 120
    
    while [ `boinccmd --get_tasks | cat | wc -l` -le 2 ]
    do
        /usr/bin/boinccmd --project http://boinc.bakerlab.org/rosetta/ update
        sleep 15
    done
    
    tail -f /dev/null
fi
