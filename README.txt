= What is it? =
This is a sample project which implements basic custom registration and login functionality, 
as well as omniauth (twitter / facebook / whatever) login functionality as well.

Both are able to be used.

The database used is mongo - which was suitable for what I originally used this for,
and may or may not be suitable for your application (but it should be easy enough to switch out).

There is no DB Mapping library used - for mongo I find them to be buggy.


Please note:
The custom login requires more secure encryption of passwords, 
users should have their own salt.

== Requirements ==

Ruby (I'm using ruby 1.9.3)
  - http://www.ruby-lang.org/en/downloads/
  - https://github.com/sstephenson/rbenv/ (this is what I'm using, along with https://github.com/sj26/rbenv-install)

Mongo (http://www.mongodb.org/downloads) 
  - start it up with 'mongod'



== Getting started ==
=== Make sure you ===

Install your gems:
 * gem install bundler -v 1.2.0.pre
 * bundle install

Get twitter keys to try out omniauth ( https://dev.twitter.com/apps/new ) 
Set these as environment variables (I put them in .bashrc)
	TWITTER_KEY,
  TWITTER_SECRET_KEY

=== It's alive, alive! ====
To start type in 'rackup' and you're all set to go!