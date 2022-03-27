#!/usr/bin/env bash

set -eo pipefail
shopt -s expand_aliases
source ~/.bashrc

command="${1}"
project_name="${2}"
project_version="${3}"

if [[ -z "${command}" || -z "${project_name}" || -z "${project_version}" ]]; then
    echo "Usage: ${0} [build | push] PROJECT VERSION"
    echo ""
    echo "Example: ${0} build usbipd-win 2.1.0"
    exit 1
fi

case "${command}" in
    build | push)
        ;;

    *)
        echo "Unknown command: ${command}"
        exit 2
        ;;
esac

current_git_ref=$(git rev-parse --abbrev-ref HEAD)

git stash
git checkout "${project_name}-v${project_version}"

for subproject_name in "${project_name}"*; do
    cd "${subproject_name}"

    case "${command}" in
        build)
            choco pack
            ;;

        push)
            choco push "${subproject_name}.${project_version}.nupkg"
            ;;
    esac

    cd ..
done

git checkout "${current_git_ref}"
git stash pop
