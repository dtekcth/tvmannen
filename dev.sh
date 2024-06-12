#!/bin/sh
set -e
printf 'Changing Working Directory to %s\n' "${0%/*}"
cd "${0%/*}"

name="${0##*/}"

setup() {
  virtualenv venv
  ./venv/bin/pip -r requirments.txt
}

run() {
  cd src
  SECRET_KEY="${SECRET_KEY:-default}" ../venv/bin/uwsgi --enable-threads --http-socket :"${PORT:-8080}" --module tv:app
}

shell() {
  export PATH="$PWD/venv/bin:$PATH" 
  bash
}

usage() {
  cat <<EOF
USAGE: $name [CMD]
  where CMD is one of:
  - setup: create a python virtualenv
  - run:   run the server locally on port 8080
  - shell: open a shell with virtualenv in path
  - help:  shows this
EOF
}

case "$1" in
  setup)
    setup
    ;;
  run)
    run
    ;;
  shell)
    shell
    ;;
  *)
    usage
    ;;
esac
