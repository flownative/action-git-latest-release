# Git Latest Release Github Action

This Github action looks for a commit tagged as "latest" in the current Git repository and tries
to determine a version Git tag (one prefixed with "v") for that commit.

In short, if you have a commit which is tagged as "v1.2.5-3", which is also tagged as "latest",
this action will return "v1.2.5-3" as its "tag" output.

## Example workflow

````yaml
name: Rebuild latest release
on:
  schedule:
    - cron: '0 0 * * *'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:

      - uses: actions/checkout@v2
        with:
          ref: 'latest'

      - name: Determine latest released version
        id: latest_version
        uses: flownative/action-git-latest-release@v1

      - name: Build Docker image
        uses: flownative/action-docker-build@v1
        with:
          tag_ref: ${{ steps.latest_version.outputs.tag }}
          image_name: flownative/docker-base/base
          registry_password: ${{ secrets.GITHUB_TOKEN }}
````
