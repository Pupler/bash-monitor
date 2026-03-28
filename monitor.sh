#!/bin/bash

set -euo pipefail

CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
YELLOW='\033[1;33m'
RESET='\033[0m'
THRESHOLD=70

print_status() {
    echo -e "${CYAN}==>${RESET} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${RESET} $1"
}

print_error() {
    echo -e "${MAGENTA}[ERROR]${RESET} $1"
}

check_cpu() {
    local cpu_usage
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'.' -f1)
    print_status "CPU usage: ${cpu_usage}%"
    if [ "${cpu_usage}" -gt "${THRESHOLD}" ]; then
        print_warning "CPU usage is high: ${cpu_usage}%"
    fi
}