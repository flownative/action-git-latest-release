#!/bin/sh
set -x

git fetch
git checkout latest

echo ::set-output name=tag::$(git describe --tags --match='v*' --abbrev=0)
