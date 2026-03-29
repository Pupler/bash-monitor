#!/bin/bash

set -euo pipefail

export LC_ALL=C
export LANG=C

# shellcheck disable=SC1091
source "$(dirname "$0")/lib/helpers.sh"
# shellcheck disable=SC1091
source "$(dirname "$0")/lib/checks.sh"

clear
check_cpu
check_ram
check_disk
check_network
check_processes