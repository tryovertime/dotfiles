#!/bin/bash

source "scripts/hostsmod.sh"
source "scripts/firststeps.sh"

speedup_dnf

sudo dnf update -y

hosts_mod

