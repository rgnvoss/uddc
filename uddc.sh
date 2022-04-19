#!/bin/bash

## Universal Diagnostic Data Collector front-end (uddc.sh)
## formerly 'getlogs.sh'
## Written by Rob Voss

TERM=ansi

function mainMenu() {
    
    TITLE=`./uddc --mversion`
    HOST=`hostname | sed 's/\..*//g'`
    KEYWORDS=()

    for KEY in `./uddc --gimme`; do
        KEYWORDS=(${KEYWORDS[@]} $KEY ".")
    done

    KEYOUT=$(whiptail --title " $TITLE " --menu "Select issue type:" 22 75 14 "${KEYWORDS[@]}"  3>&1 1>&2 2>&3)

    if [ "$KEYOUT" != "" ]
        then
            NOW=`date +%Y%m%d%H%M%S%z`
            OUTPATH=`pwd`
            OUTFILE="uddc_"$HOST"_"$KEYOUT"_"$NOW".tgz"
 
            if (whiptail --title "Universal Diagnostic Data Collector" --yesno "Gather diagnostic data for "$KEYOUT" issues?" 8 78); then
                if (whiptail --title "Universal Diagnostic Data Collector" --yesno "List diagnostic data to be collected?" 8 78); then
                    ./uddc --mget "$KEYOUT" --test
                    whiptail --title "Universal Diagnostic Data Collector" --textbox /tmp/files_out 12 80 --scrolltext
                    rm /tmp/files_out
                fi
                unbuffer ./uddc --mget "$KEYOUT" --output "$OUTFILE" | whiptail --gauge "Gathering "$KEYOUT" diagnostic data." 6 50 0
                if [[ -f "/tmp/errors_out" ]]; then
                    if (whiptail --title "Universal Diagnostic Data Collector" --yesno "Completed with errors. Show errors?" 8 78); then
                        whiptail --title "Universal Diagnostic Data Collector" --textbox /tmp/errors_out 12 80 --scrolltext
                    fi
                    rm /tmp/errors_out
                fi
                    whiptail --title "Universal Diagnostic Data Collector" --msgbox "Data saved to '"$OUTPATH"/"$OUTFILE"'.\nREMINDER: This only contains data for "$HOST"." 8 78
                else
                    mainMenu
            fi
    fi

}


if [ $# -eq 0 ]
    then
        mainMenu
    else
        if [[ " $@ " =~ " --help " || " $@ " =~ " -h " || " $@ " =~ " --show " || " $@ " =~ " -s " ]]
            then
                ./uddc $@ | sed 's/ Beta/m Beta/g' | sed 's/ RC/m RC/g' | sed 's/ Stable/m Stable/g' | sed 's/ Final/m Final/g' | sed 's/(uddc)/(uddc.sh)/g' | sed 's/: uddc/: uddc.sh/g' | less
            else
                ./uddc $@
        fi
fi
