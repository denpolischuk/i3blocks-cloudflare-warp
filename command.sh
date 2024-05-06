#!/usr/bin/bash

# Silent exit if warp-cli is not installed
if ! which warp-cli>/dev/null; then exit 1; fi;

warp_status=$(warp-cli -v status | grep 'Status update' | awk '{print $3}' | sed 's/\.//')
status_str=""
if [[ $warp_status == "Connected" ]]; then
  status_str=" WARP: 󱐋 $warp_status "
  if [ $BLOCK_BUTTON ]; then
    warp-cli disconnect >> /dev/null;
    status_str=" WARP:  Disconnecting... "
  fi
else 
  status_str=" WARP:  $warp_status "
  if [ $BLOCK_BUTTON ]; then
    warp-cli connect >> /dev/null;
    status_str=" WARP: 󱐋 $Connecting... "
  fi
fi
printf "$status_str"
