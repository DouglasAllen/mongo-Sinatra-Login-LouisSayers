require 'test/unit'
require 'rack/test'
require_relative '../testHelpers/rspec_matchers'
require_relative 'test_db_setup'

root = File.dirname(__FILE__) + '/../'
require root + 'appconfig'
require root + 'appsetup'

Dir[root + 'controllers/*.rb'].each {|file| require file }
Dir[root + 'models/*.rb'].each {|file| require file }
Dir[root + 'repository/*.rb'].each {|file| require file }

set :environment, :test
set :root, File.dirname(__FILE__) + '/../'

def app
  Sinatra::Application
end

