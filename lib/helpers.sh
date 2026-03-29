# shellcheck shell=bash

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