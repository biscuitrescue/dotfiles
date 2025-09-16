#!/usr/bin/env bash
for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v main`; do
    git branch --track ${branch##*/} $branch
done
