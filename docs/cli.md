# exloc-cli

Written in bash/shell. Takes advantage of curl to make Web API requests.

## Example Usage

CRUD actions:

```no-highlight
$ exloc get ex-slug  # download an example
$ exloc post         # create an example
$ exloc patch        # update an example
$ exloc delete slug  # delete an example
```

Other functionality:

```no-highlight
$ exloc new name     # start a new exloc repo
$ exloc browse slug  # open example in the browser
$ exloc search keyword
$ exloc vote slug
```

## get

```no-highlight
$ curl --request GET \
    -F "token=$EXLOC_TOKEN" \
    exloc.io/ex/slug.{json,zip,tar.gz,tar.bz2,rar,7z}
```

Working commands:

```no-highlight
$ curl --request GET \
    --location \  # follow redirects
    http://localhost:3000/ex/radavis-github-card.tarball \
    --output github-card.tar.gz

$ curl --request GET \
    --location \  # follow redirects
    http://localhost:3000/ex/radavis-github-card.zip \
    --output github-card.zip
```

Print server response status and body. `cd` into uncompressed repository.

Probably fine to pick a single, widely supported compression method.

## post

From within a git repo...

```no-highlight
$ curl --request POST \
    -F "token=$EXLOC_TOKEN" \
    -F "git=https://github.com/username/repository" \
    exloc.io/ex
```

Print server response status and body.
  - "re-post" existing example -> reject, recommend patch
  - fails validation -> print errors listed in response body

## patch

```no-highlight
$ curl --request PATCH \
    -F "token=$EXLOC_TOKEN" \
    -F "git=https://github.com/username/repository" \
    exloc.io/ex/slug
```

## delete

```no-highlight
$ curl --request DELETE \
    -F "token=$EXLOC_TOKEN" \
    exloc.io/ex/slug
```

## browse slug

Visit the exloc url in the browser. Optional slug argument.

## search {keyword}

Returns a list of the ten best matches for a search.

## vote

```no-highlight
$ curl --request POST \
    -F "token=$EXLOC_TOKEN" \
    exloc.io/ex/slug/votes
```
