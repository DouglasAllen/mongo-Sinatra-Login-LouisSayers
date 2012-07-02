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

Please note:
The custom login requires more secure encryption of passwords, 
users should have their own salt.