StuDs 2013
==========

This is the website for StuDs, or Datasektionens studieresa (study tour).


Getting started
---------------

Install all gem dependencies through bundle (optionally skipping gems required in production):

```bash
bundle install --without production
```

Create a admin user for yourself in the rails console (started with `rails c`), or by running `rake db:seed`:

```ruby
User.create(login: 'admin', email: 'admin@test.se', password: '4v8dfk', role: 'admin')
```

You should now be good to go! Next step is to start the web server (unless running on Passenger or equivalent):

```bash
rails server
```

Generating PDF resumes
----------------------

PDF Resumes are generated through the `pdflatex` command line tool.
The LaTeX template depends on multiple packages which will probably require you to install
additional stuff for the `pdflatex` compatible tools you use.

* Ubuntu: `sudo apt-get install texlive-latex-extra texlive-lang-swedish`.


Authors
-------

* Victor Hallberg <<victorha@kth.se>>
