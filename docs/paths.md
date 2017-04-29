# API Paths

## Users

```no-highlight
GET/POST/PATCH/DELETE exloc.io/usr/nickname-provider{.format}
```

Auth Providers:

* [x] GitHub
* [x] GitLab
* [x] Twitter

Supported Formats:

* [ ] html
* [ ] json
* [ ] txt,sh,rb - j/k

## Examples

```no-highlight
GET/POST/PATCH/DELETE exloc.io/ex/slug{.format}
```

Supported Formats:

* [x] html
* [ ] {zip,tar.gz,tar.bz2,rar}
* [ ] json
* [ ] git url(?)

## Voting

```no-highlight
POST exloc.io/ex/slug/vote
```
