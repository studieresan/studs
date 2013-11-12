studs 2014
==========

This is the website for studs, which can be found at [here](http://studs.datasektionen.se).


Getting started
---------------

```bash

# Install all gem dependencies through bundle (optionally skipping gems required in production)
bundle install --without production

# Create a database configuration (uses a SQLite3 database by default in dev environments)
cp config/database.yml.dist config/database.yml

# Initialize the database (create tables and stuff)
bundle exec rake db:setup
# Write down the admin password output by this command

# Start the server
rails server
```

Open up [localhost:3000](http://0.0.0.0:3000/) in your favorite browser and verify that it works.
You can then log in to the admin account by visiting [localhost:3000/login](http://0.0.0.0:3000/login)
and entering the credentials output by the `rake db:setup` command earlier.


Generating PDF resumes
----------------------

PDF Resumes are generated through the `pdflatex` command line tool.
The LaTeX template depends on multiple packages which will probably require you to install
additional stuff for the `pdflatex` compatible tools you use.

* Ubuntu: `sudo apt-get install texlive-latex-extra texlive-lang-swedish`.

Deploying
---------

```bash
bundle exec cap production deploy
```

Authors
-------

* Martin Barksten <<barksten@kth.se>>
* Per Classon <<pclasson@kth.se>>
* Victor Hallberg <<victorha@kth.se>>
* Jonas Sköld <<jonassko@kth.se>>