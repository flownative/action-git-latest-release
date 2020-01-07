#!/bin/sh
set -x

git fetch --depth=100 origin +refs/tags/*:refs/tags/*
echo ::set-output name=tag::$(git describe --tags --match='v*' --abbrev=0)
