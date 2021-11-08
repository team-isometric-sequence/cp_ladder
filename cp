#!/bin/bash

cp=${BASH_SOURCE[0]}

install() {
    mix deps.get; yarn;
    cd client && yarn;
}

test() {
    mix test $@;
}

shell() {
    iex -S mix
}

migrate() {
    mix ecto.migrate
}

run() {
    local target=${1:-all}

    case $target in
        server)
            yarn concurrently --raw --kill-others-on-fail \
                "mix phx.server" \
                "cd client && yarn dev"
            ;;
        *)
            echo "Exit...";
            ;;
    esac
}

trap exit SIGINT

eval "$@"
