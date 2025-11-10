#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
declare -a topics
source "${SCRIPT_DIR}/topics.sh"

run_pdflatex() {
    local tex_directory=$1
    local tex_file=$2
    local tex_path="${tex_directory}/${tex_file}"
    local log_file="${tex_file%.tex}.log"
    echo "Building '${tex_path}'..."
    pushd "${tex_directory}" >/dev/null || return 1

    if pdflatex -halt-on-error -interaction=nonstopmode "${tex_file}" >/dev/null 2>&1; then
        echo -e "$(tput setaf 2)Compiling '${tex_path}' was successful!$(tput sgr0)"
        echo
        popd >/dev/null
        return 0
    else
        echo -e "$(tput setaf 1)There was an error compiling '${tex_path}'. See ${tex_directory}/${log_file} for details.$(tput sgr0)"
        if [[ -f "${log_file}" ]]; then
            echo "Last 20 lines of '${tex_directory}/${log_file}':"
            tail -n 20 "${log_file}"
        fi
        echo
        popd >/dev/null
        return 1
    fi
}

# Print all items in the array, just to demonstrate
build_failed=0
for topic in "${topics[@]}"; do
    if [ -f "${topic}/paper.tex" ]; then
        if ! run_pdflatex "${topic}" "paper.tex"; then
            build_failed=1
        fi
    elif [ -f "${topic}/presentation.tex" ]; then
        if ! run_pdflatex "${topic}" "presentation.tex"; then
            build_failed=1
        fi
    else
        echo "Couldn't find ${topic}/paper.tex nor ${topic}/presentation.tex. Exiting..."
        exit 1
    fi
done

exit ${build_failed}
