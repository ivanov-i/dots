#!/bin/bash

# batteries.sh - A script to display device names and battery levels without leading whitespace

# Use ioreg to get device information, grep to filter for device names and battery levels,
# and awk to format the output, pairing device names with their battery levels and removing leading whitespace.
ioreg -r -l -n AppleDeviceManagementHIDEventService | grep -E '"Product"|"BatteryPercent"' | awk '
/Product/ {
    gsub(/"Product" = /, "");
    gsub(/;$/, "");
    sub(/^[ \t]+/, "", $0); # Remove leading whitespace
    deviceName = $0;
    getline;
}
/BatteryPercent/ {
    gsub(/"BatteryPercent" = /, "");
    gsub(/;$/, "");
    sub(/^[ \t]+/, "", $0); # Remove leading whitespace
    batteryLevel = $0;
    print deviceName ": " batteryLevel;
}'

# End of script

