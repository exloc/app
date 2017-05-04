# exloc

A document to describe the exloc idea.

* a code example (EXample Lines-Of-Code)
* uses modern tools to document each exloc
  - markdown
  - git
    * import of remote repositories
    * core of example is the last commit, separate from any framework-generated code.
  - code files imported from GitHub and stored as jsonb columns in Postgres
* lists files that are of importance (to be imported)
* multiple examples (series) from a single repo (array of exlocs in exloc.json)
