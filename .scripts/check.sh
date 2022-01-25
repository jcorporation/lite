#!/bin/bash

check_permalink() {
    F=$1
    P=${F%.*} # remove extension
    PERMALINK="${P:1}" # remove first char

    if ! grep -q "^permalink: $PERMALINK" "$F"
    then
        echo "Invalid permalink: $F"
    fi
}

check_title() {
    F=$1

    if ! grep -P -q '^title: \S+' "$F"
    then
        echo "Empty title: $F"
    fi
}

for F in $(find ./ -name \*.md)
do
    [ "$F" = "./README.md" ] && continue
    # check links
    .scripts/check-links.pl "$F"
    # check permalink
    check_permalink "$F"
    # check title
    check_title "$F"
done
