# exloc-cli

Written in bash/shell. Takes advantage of curl to make Web API requests.

## Example Usage

```no-highlight
$ exloc get ex-slug
$ exloc post
$ exloc patch
$ exloc delete
$ exloc vote
```

## get

```no-highlight
$ curl --request GET \
    -F "token: $EXLOC_TOKEN" \
    exloc.io/ex/slug.{json,zip,tar.gz,tar.bz2,rar,7z}
```

Print server response status and body. `cd` into uncompressed repository.

Probably fine to pick a single, widely supported compression method.

## post

From within a git repo...

```no-highlight
$ curl --request POST \
    -F "token: $EXLOC_TOKEN" \
    -F "git=https://github.com/username/repository" \
    exloc.io/ex
```

Print server response status and body.
  - "re-post" existing example -> reject, recommend patch
  - fails validation -> print errors listed in response body

## patch

```no-highlight
$ curl --request PATCH \
    -F "token: $EXLOC_TOKEN" \
    -F "git=https://github.com/username/repository" \
    exloc.io/ex/slug
```

## delete

```no-highlight
$ curl --request DELETE \
    -F "token: $EXLOC_TOKEN" \
    exloc.io/ex/slug
```

## vote

```no-highlight
$ curl --request POST \
    -F "token: $EXLOC_TOKEN" \
    exloc.io/ex/slug/votes
```
