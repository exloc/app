# Features

* [ ] regularly check repo for updates
* [ ] subscribe to webhooks for repository
* [ ] exclusive to invited users
* [ ] setup airbrake/rollbar/error notification
* [ ] subscribe to exloc.json file search on GitHub, Bitbucket, etc (pickup "undocumented" examples)
* [ ] determine dependencies via Gemfile, package.json, requirements.txt, etc
* [ ] favorite code examples
* [ ] search examples (full-text/elasticsearch)
* [ ] userscore based on positivity of submissions
  - is it useful to others? (via votes)
  - is it a working example? (commands to execute example yield a positive result)
* [ ] penalty for spamming useless examples in a short period of time
* [ ] ratelimit submissions (5 per day, for example)
* [x] add URL json field in code_examples table, for exloc.json and repo data
* [x] no downvoting

# Problems to Solve/Questions to Answer

* [ ] Setting up CNAME and such on NameCheap and Heroku
* [ ] HTTPS/SSL with Heroku and LetsEncrypt
* [x] Is mongodb a reasonable choice as a data store? (search, auth, etc) - Yes and no. Better to use ActiveRecord/PSQL w/ JSONB since I am more familiar with that.
