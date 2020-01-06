# Git Latest Release Github Action

This Github action looks for a commit tagged as "latest" in the current Git repository and tries
to determine a version Git tag (one prefixed with "v") for that commit.

In short, if you have a commit which is tagged as "v1.2.5-3", which is also tagged as "latest",
this action will return "v1.2.5-3" as its "tag" output.

## Example workflow

````yaml
…
````
