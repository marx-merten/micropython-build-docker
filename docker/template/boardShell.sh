#!/bin/bash
# This script is used to connect to the board using rshell
# To select the port, run "source ./selectSerialPort.sh" and select the port

echo "Choosen $RSHELL_PORT"
rshell  $*