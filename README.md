# Git Latest Release GitHub Action

This GitHub action looks for a commit tagged as "latest" in the current
Git repository and tries to determine a version Git tag (one prefixed
with "v") for that commit.

In short, if you have a commit which is tagged as "v1.2.5+3", which is
also tagged as "latest", this action will return "v1.2.5+3" as its "tag"
output.

Additionally, this action also returns just the version number as a
dedicated output. In the example above, "version" will contain "1.2.5".

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

      - uses: actions/checkout@v4
        with:
          ref: 'latest'

      - name: Determine latest released version
        id: latest_version
        uses: flownative/action-git-latest-release@v1

      - uses: actions/checkout@v4
        with:
          ref: ${{ steps.latest_version.outputs.tag }}
          fetch-depth: 100

      - name: Docker meta
        id: meta
        uses: docker/metadata-action@v3
        with:
          flavor: |
            latest=true
          images: |
            harbor.example.com/acme/my-app
          tags: |
            type=semver,pattern={{major}},value=${{ steps.latest_version.outputs.version }}
            type=semver,pattern={{major}}.{{minor}},value=${{ steps.latest_version.outputs.version }}
            type=semver,pattern={{version}},value=${{ steps.latest_version.outputs.version }}

      - name: Set up QEMU
        id: qemu
        uses: docker/setup-qemu-action@v3

      - name: Set up Docker Buildx
        id: buildx
        uses: docker/setup-buildx-action@v3
````
