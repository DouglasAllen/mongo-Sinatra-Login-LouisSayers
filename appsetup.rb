require 'sinatra'
require 'sinatra/content_for'

require_relative 'apphelpers'

Dir[File.dirname(__FILE__) + '/controllers/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/repository/*.rb'].each {|file| require file }

enable :sessions
set :session_secret, "5sd6f5sdSDFE84#L5y64h5g4dhfgsfa84914%123@340123l;0twer623$"

ENV['RACK_ENV'] ||= 'development'
  
set :show_exceptions, true
  
if(ENV['RACK_ENV'] != 'development' && ENV['RACK_ENV'] != 'test')
  set :show_exceptions, false
end
  
$user_repository = UserRepository.new

before '*' do
  if(!request.ssl? && request.host != 'localhost')
    request_url = request.env['REQUEST_URI']
    request_url['http'] ='https' 
    redirect request_url
  end
end