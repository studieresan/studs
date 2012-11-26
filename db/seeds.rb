# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Create admin user
name = 'admin'
password = '4v8dfk'
User.create({ login: name, email: 'admin@root.com', password: password, role: 'admin'}, as: :admin)
STDOUT.puts "Created admin user with login '#{name}' and password '#{password}'"
