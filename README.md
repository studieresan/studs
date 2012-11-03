StuDs 2013
==========

This is the website for StuDs, or Datasektionens studieresa (study tour).

Getting started
---------------

Install all gem dependencies through bundle (optionally skipping gems required in production):

```bash
bundle install --without production
```

Create a admin user for yourself in the rails console (started with `rails c`):

```ruby
User.new(login: 'admin', email: 'admin@test.se', password: '4v8dfk', role: 'admin').save
```

You should now be good to go! Next step is to start the web server (unless running on Passenger or equivalent):

```bash
rails server
```

Authors
-------

* Victor Hallberg <<victorha@kth.se>>
