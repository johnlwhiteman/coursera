#!/usr/bin/env bash
export PDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

run_installer() {
    if command -v apt >/dev/null 2>&1; then
        sudo apt install -y "$1"
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y "$1"
    elif command -v yum >/dev/null 2>&1; then
        sudo yum install -y "$1"
    fi
}

setup_chrome() {
    curl -o /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    run_installer "/tmp/chrome.deb"
    rm -f "/tmp/chrome.deb"
}

setup_os() {
    if command -v apt >/dev/null 2>&1; then
        sudo apt update -y && sudo apt install -y curl 
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf update -y && sudo dnf install -y curl
    elif command -v yum >/dev/null 2>&1; then
        sudo yum update -y && sudo yum install -y curl
    fi
}

setup_python() {
    if [ ! -d "${PDIR}/venv" ]; then
        echo "Setting up venv"
        python -m venv "${PDIR}/venv"
    fi
    source ${PDIR}/sourceme.sh 
    python -m pip install --upgrade pip
    pip install -r "${PDIR}/requirements.txt" --upgrade
}

#setup_os
setup_python
#setup_chrome
