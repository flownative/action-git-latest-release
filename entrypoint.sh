#!/bin/sh
set -x

git config --global --add safe.directory ${GITHUB_WORKSPACE}
git fetch --depth=100 origin +refs/tags/*:refs/tags/*
echo ::set-output name=tag::$(git describe --tags --match='v*' --abbrev=0)
echo ::set-output name=version::$(git describe --tags --match='v*' --abbrev=0 | grep -oE '[0-9.]+' | head -n 1)
