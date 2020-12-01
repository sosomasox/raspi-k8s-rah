#!/bin/bash

sleep 30

/usr/bin/boinccmd --read_cc_config

if [ $ROSETTA_AT_HOME_ACCOUNT_KEY != "" ]; then
    /usr/bin/boinccmd --project_attach https://boinc.bakerlab.org/rosetta/ $ROSETTA_AT_HOME_ACCOUNT_KEY
    /usr/bin/boinccmd --project https://boinc.bakerlab.org/rosetta/ update
    sleep 120
    
    while [ `boinccmd --get_tasks | cat | wc -l` -le 2 ]
    do
        /usr/bin/boinccmd --project https://boinc.bakerlab.org/rosetta/ update
        sleep 30
    done
    
    tail -f /dev/null
fi

exit 0
