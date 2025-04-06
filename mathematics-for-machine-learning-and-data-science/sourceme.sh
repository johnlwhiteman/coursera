#!/usr/bin/env bash
export PDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export BDIR=${PDIR}/bin
export VENV=${PDIR}/venv

if [ -d "$VENV" ]; then
    source ${VENV}/bin/activate
fi

export PYTHONPATH=${PDIR}/lib
export PATH=${PDIR}/bin:${PATH}
