# exloc-app

A community-driven problem solving resource.

[Web App](https://exloc.io)

## Documentation

* [Manifesto](docs/manifesto.md)
* [MVP](docs/mvp.md)
* [Features](docs/features.md)

## Goals

Create a centralized resource for code examples that are:

1. Downloadable
2. Immediately executable (build instructions **must** be included and yield a positive result)
3. Indexed (searchable)
4. Curated (through voting)
5. Community-driven (anyone can add or revise an example)

## Motivations

* StackOverflow is great, but doesn't give you all the context for running an example.
* Blog posts are great, but often don't tell you which revision of a technology they are using.
* Examples you find on the Internet are great, but involve a fair amount of copy-pasting and modifying to get started.

## Ways to Contribute

* Participate: vote for working examples, add comments to encourage discussion.
* Test code example instructions: download using curl and vote via the CLI.
* Add new code examples
  - compose in Markdown (md), site your source(s)
  - via git repo (include 'exloc.json', 'exloc.md', and source code files)
* Work on features. Specs in the form of user stories are available in the 'features' branch.

# Tech

* Ruby
* Rails
* Postgres
* JavaScript
* HTTP (duh)
* Git

## Models

### CodeExample

#### exloc.json

* name
* technologies, versions
* build dependencies (setup script)
* build commands/script
* license

#### Fields

* content (in markdown)
* license_id
* git (url)

#### Relationships

* has_many technologies
* belongs_to user

### Technology

* name
* synonyms
* icon
