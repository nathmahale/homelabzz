#!/bin/bash

msg=$1

function add_files() {
    echo "added all the files"
    git add --all

}

function commit_message() {
    echo "committed with the message --> ${msg}"
    git commit -m "${msg}"

}

function push_remote() {
    echo "pushed to remote"
    git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)

}


add_files
commit_message
push_remote
