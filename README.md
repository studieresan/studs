studs 2014
==========

This is the website for studs, which can be found at [here](http://studs.datasektionen.se).


Getting started
---------------

[Install the latest version of ruby 2.*](https://www.ruby-lang.org/en/installation/) and [the latest 3.* version of rails](http://rubyonrails.org/download).

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
You can now login using the credentials of rake db:setup.

Generating PDF resumes
----------------------

PDF Resumes are generated through the `pdflatex` command line tool.
The LaTeX template depends on multiple packages which will probably require you to install
additional stuff for the `pdflatex` compatible tools you use.

* Ubuntu: `sudo apt-get install texlive-latex-extra texlive-lang-swedish`.

Webfaction
----------

The server is hosted on [webfaction](http://www.webfaction.com). The login credentials can be found in shared
Google Doc. For problems with Webfactional refer to their [documentation](https://docs.webfaction.com/software/index.html).

Database configuration
----------------------

The configuration file for the database can be found in 

    /home/studs/webapps/PROJECT/shared

where PROJECT is rails for the production server and rails_staging for the staging one. 
Deploying
---------

Deploying can be done either to the staging server or the production one. For the general configuration see

    config/deploy.rb

### Staging

The staging server is deployed to using

```bash
bundle exec cap deploy
```

The staging-specific configuration can be found at

    config/deploy/staging.rb

### Production

The code will be pulled from the be the *master* branch and the command to run is

```bash
bundle exec cap production deploy
```

The production-specific configuration can be found at

    config/deploy/production.rb

Workflow
--------

* The *master* branch should always be up to date, that is it should at any given time be possible to deploy the code to the live server.
* The *staging* branch should only be used as the final step to verify all code works in production mode on the server.
* The *dev* branch is the one where finished featues and changes should be added.

Below is the workflow to use when developing. The workflow ensures that the staging and master branches remain up to date, and in sync with each other.

### Adding a new feature

When adding a new feature develop it on a separate branch.

```bash
# Create a new branch (make sure you are currently on the dev branch when doing this)
git checkout -b branch-name

# Do your edits on the branch, committing and pushing them

# When you are done switch back to the dev branch
git checkout dev

# Pull dev, merge the new branch into dev and push to dev
git pull origin dev
git merge branch-name
git push origin dev
```

### Releasing a new version

When a new release is deployed always verify it works on the staging server first.

```bash
# Switch to the staging branch
git checkout staging

# Pull staging, merge dev branch into staging and push to staging
git pull origin staging
git merge dev
git push origin staging

# Deploy your code
cap deploy

# Verify everything works on the server

# Now switch to master
git checkout master

# Pull master, merge dev branch into master and push to master
git pull origin master
git merge staging
git push origin master

# Deploy your code to the production server
cap production deploy
```

### Hotfixing

When a new release is deployed always verify it works on the staging server first.

```bash
# Switch to the staging branch
git checkout staging

# Add the code necessary to fix it

# Deploy your code
cap deploy

# Verify everything works on the server

# Now switch to master and merge the staging branch into it
git checkout master
git merge staging

# Deploy your code to the production server
cap production deploy

# Merge the staging branch into dev to ensure both are up to date
git checkout dev
git merge staging
```

Authors
-------

* Martin Barksten <<barksten@kth.se>>
* Per Classon <<pclasson@kth.se>>
* Victor Hallberg <<victorha@kth.se>>
* Jonas Sköld <<jonassko@kth.se>>
