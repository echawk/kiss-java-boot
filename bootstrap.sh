#!/bin/sh

[ "$(basename "$PWD")" = 'kiss-java-boot' ] || exit 1

script="$(mktemp)"

sed -n '/```/=' README.md \
    | paste -d',' - - \
    | xargs -I{} sed -n '{}p' README.md \
    | grep -v '```' > "$script"

sh -xe "$script"
rm --  "$script"
