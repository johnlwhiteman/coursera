#!/usr/bin/env bash
export PDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export VENV="${PDIR}/venv/bin/activate"

if [ ! -f "$VENV" ]; then
    echo "Abort: You need to run the setup.sh script first"
    exit -1
fi

source $VENV
export PATH=${PDIR}/bin:${PATH}
export PYTHONPATH=${PDIR}/lib
