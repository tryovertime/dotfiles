#!/bin/bash

# Speed up DNF

speedup_dnf() {
content="
[main]
gpgcheck=True
installonly_limit=3
clean_requirements_on_remove=True
best=False
skip_if_unavailable=True
fastestmirror=True
max_parallel_downloads=10
defaultyes=True
keepcache=True
"

echo "$content" >> /etc/dnf/dnf.conf

echo "<<<.....Speed up DNF completed.....>>>"
}





