#!/usr/bin/env bash

sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -z - --threads=0)/g' /etc/makepkg.conf