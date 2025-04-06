#!/usr/bin/env bash

run_installer() {
    if command -v apt >/dev/null 2>&1; then
        sudo apt install "$1" -y
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install "$1" -y
    elif command -v yum >/dev/null 2>&1; then
        sudo yum install "$1" -y
    fi
}

setup_chrome() {
    if command -v google-chrome --version >/dev/null 2>&1; then
        return 0
    fi
    SRC_URL=https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    if command -v dnf >/dev/null 2>&1; then
        SRC_URL=https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
        TGT_PATH=/tmp/google-chrome.rpm
    fi
    if [ ! -f "$TGT_PATH" ]; then
        curl -L -o $TGT_PATH $SRC_URL
    fi
    run_installer $TGT_PATH
}

setup_os() {
    if command -v apt >/dev/null 2>&1; then
        sudo apt update -y && sudo apt upgrade -y
        sudo apt install -y curl git
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf update -y && sudo dnf upgrade -y
        sudo dnf install -y curl git
    elif command -v yum >/dev/null 2>&1; then
        sudo yum update -y && sudo yum upgrade -y
        sudo yum install -y curl git
    fi
}

setup_python() {
    if ! command -v "python --version" &> /dev/null; then 
        sudo alternatives --install /usr/bin/python python /usr/bin/python3 1
    fi
    python --version

    if [ ! -d "${VENV}" ]; then
        echo "Setting up the python venv"
        python -m venv "$VENV"
    fi
    python -m ensurepip --default-pip
    python -m pip install --upgrade pip
    pip install -r "${PDIR}/requirements.txt" --upgrade
}

setup_os
setup_python
setup_chrome
