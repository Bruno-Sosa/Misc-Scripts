#!/bin/bash
# Usage: bash <filename>

echo "Choose a network interface: "
ip link | grep 'wl[[:alpha:]][[:digit:]]' -o --color
read Network_interface
