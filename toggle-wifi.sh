#!/usr/bin/env bash

# vim:set filetype=bash :

adapter=en1

# Turn WiFi off
networksetup -setairportpower $adapter off

# Wait for 5 seconds
sleep 5

# Turn WiFi back on
networksetup -setairportpower $adapter on

