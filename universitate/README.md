## Introduction
*__Universitate is your first step towards the future.__*

Here you can find thousand of teachers dedicated to teach and help you to improve your skills and knowledge in one or many subjects.

If you decided to go to the university, you can search teachers who work specifically in that institution. Also, you can filter and sort teachers by:

  - Subject
  - Region
  - Rating

We will provide you the option to make contact with the teacher through our website for your security.

You can perform your search at any time but you will need to create an account if you want to hire a service.

If you are a teacher you have to create your profile and also you can validate it with other social network.

As a teacher you will have the option to create group lessons to optimize your time and also a calendar where you can follow day by day your work schedule.

When the lesson is done both the student and the teacher may rate to each other.

### Technologies

__Universitate__ uses a number of open source projects to work properly:

* [React] - A javascript library for building user interfaces!
* [Twitter Bootstrap] - Great UI boilerplate for modern web apps.
* [Ruby] - A dynamic open source programming language.
* [RoR] - Framework to build a modern web application.

## Installation
##### RVM, Ruby and RoR

First thing you need to do is install RVM to manage your ruby versions.
```bash
$ \curl -L https://get.rvm.io | bash -s stable
```
After installing RVM, you must close and reopen the Terminal window.

Now you need to install the newest version of Ruby.
```bash
$ rvm install ruby-2.3.1
```
> Ruby 2.3.1 was current when this was written.

Verify that the newest version of Ruby is installed:
```bash
$ ruby -v
ruby 2.3.1...
```
RubyGems is the package manager in Ruby. We use it to install software packages that add functionality to Ruby. We need to check the Gem Manager
```bash
$ gem -v
2.5.1
```
Look for update for the Ruby gem manager:
```bash
$ gem update --system
```

You must install **Bundler**, this gem is an essential tool for managing gems when developing and running Rails applications.
```bash
$ gem install bundler
```

**Nokogiri** is a gem that is a dependency for many other gems. Nokogiri is a gem that requires compilation for your specific operating system.
```bash
$ gem install nokogiri
```

Install the current version of **Rails** , I recommend installing the most recent stable release:

```bash
$ gem install rails
```
>Rails 5.0.0.1 was current when this was written.

Verify that the correct version of Rails is installed:
```bash
$ rails -v
Rails 5.0.0.1
```

##### Postgres

You can follow the next link to download and install Postgres depending your operating system:
https://www.postgresql.org/download/

##### Install dependencies and others.

Now you need to clone the git project into your computer:
```bash
$ git clone https://github.com/MartinCarniello/Universitate.git
```
then you need to go inside the new folder, twice:
```bash
$ cd Universitate/universitate
```
Run the command _bundle install_ to install the gems dependencies:
```bash
$ bundle install
```
> It may take time

Probably you will need to change the database configuration (username and password) in the file _database.yml_ located in the folder __config__. After that, you can run the next commands to create the databases, tables and fill it with some data.
```bash
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

Now you have everything sorted to run the application in your local server, you can do it running this command:
```bash
$ rails server
```

Go to https://localhost:3000 and see how is it working.


License
----

   [Twitter Bootstrap]: <http://twitter.github.com/bootstrap/>
   [React]: <https://facebook.github.io/react/>
   [Ruby]: <https://www.ruby-lang.org/en/>
   [RoR]: <http://rubyonrails.org/>

