#!/bin/bash
# Set monitor brighness by time or input
display_name=$(xrandr | grep " connected" | cut -f1 -d " ")

if [ -z "$1" ]
  then
    #echo "No argument supplied"

    currenttime=$(date +%H:%M)

    sunrise="0.5"
    day="0.7"
    sunset="0.7"
    evening="0.7"
    night="0.5"
    latenight="0.2"
    sleeptime="0.1"

    # sunrise
    if [[ "$currenttime" > "06:00" ]] && [[ "$currenttime" < "07:00" ]]; then
        xrandr --output $display_name --brightness $sunrise  
        echo "Current time $currenttime Brightness $sunrise"
    fi

    # day
    if [[ "$currenttime" > "07:00" ]] && [[ "$currenttime" < "17:00" ]]; then
        xrandr --output $display_name --brightness $day
        echo "Current time $currenttime Brightness $sunrise"  
    fi

    # sunset
    if [[ "$currenttime" > "17:00" ]] && [[ "$currenttime" < "18:00" ]]; then
        xrandr --output $display_name --brightness $sunset
        echo "Current time $currenttime Brightness $sunset"   
    fi


    # evening
    if [[ "$currenttime" > "17:00" ]] && [[ "$currenttime" < "23:00" ]]; then
        xrandr --output $display_name --brightness $evening
        echo "Current time $currenttime Brightness $evening"
    fi

    # night
    if [[ "$currenttime" > "23:00" ]] && [[ "$currenttime" < "02:00" ]]; then
        xrandr --output $display_name --brightness $night
        echo "Current time $currenttime Brightness $night"    
    fi

    #  late night
    if [[ "$currenttime" > "01:00" ]] && [[ "$currenttime" < "02:00" ]]; then
        xrandr --output $display_name --brightness $latenight
        echo "Current time $currenttime Brightness $latenight"  
    fi

    # sleep time 
    if [[ "$currenttime" > "02:00" ]] && [[ "$currenttime" < "06:00" ]]; then
        xrandr --output $display_name --brightness $sleeptime 
        echo "Current time $currenttime Brightness $sleeptime"   
    fi


fi


if [ $# -eq 1 ]
  then
    echo "Manuall Brightness"
    
    
    if [ $1 -lt 5 ]; then
        echo -e "Bad range. Valid Range are from 5 to 150";
    exit 1;
    fi

    if [ $1 -gt 150 ]; then
        echo -e "Bad range. Valid Range are from 5 to 150";
    exit 1;
    fi

    #manualbrightness= $(echo "scale=2 ; 50 / 100" | bc)
    manualbrightness=$(echo "scale=2; $1/100 " | bc)
    echo $manualbrightness
    xrandr --output $display_name --brightness $manualbrightness
fi





