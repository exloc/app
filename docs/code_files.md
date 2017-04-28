# Thoughts on importing code files

`exloc.json` should specify noteworthy files.

```no-highlight
{
  "name": "Exloc Code Example",
  "description": "An example repository for consumption by exloc.io.",
  "scripts": {
    "start": "node hello.js"
  },
  "dependencies": {
    "node": "6.10.2"
  },
  "files": [
    "hello.js",
    "articles/data.json"
  ],
  "license": "MIT"
}
```

On import of a code example, first store code example info, then create a file import job for each file.

```no-highlight
code_example.files.{build,create}(file_params)
# file_params: name & data (json)
```

Possibly use a Struct to convert from JSON format to AR format.

Idea: classes that map data from one format to another. 
