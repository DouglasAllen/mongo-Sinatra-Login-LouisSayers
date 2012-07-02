require 'sinatra'
require 'omniauth'
require 'omniauth-twitter'
require_relative '../models/user_auth_details'
require_relative '../models/custom_auth_details'
require_relative '../models/user'
require_relative '../models/validators/login_validator'
require_relative '../models/validators/registration_validator'
require_relative '../repository/user_repository'

use OmniAuth::Builder do
  provider :developer  if ENV['RACK_ENV'] == 'development' || ENV['RACK_ENV'] == 'test'
  provider :twitter, $config[:twitter_key], $config[:twitter_secret_key]
end

get '/login' do
  redirect '/' if session[:authentication_id]
  return_url = params[:return_url] || '/'
  erb :login, :locals => {:origin => return_url}
end

post '/register' do
  redirect '/' if session[:authentication_id]
  form_data = params[:data]
  validator = RegistrationValidator.new
  validation_info = validator.validate(form_data)
  if(validation_info.has_errors())
    return erb :"login", :locals => {:register => true, 
                                     :form_data => form_data, 
                                     :errors => validation_info.errors}
  end
  
  user_details = CustomUserAuthDetails.new(form_data[:email], form_data[:password])
    
  if $user_repository.user_exists_with(user_details)
    errors = {:emailExists => "#{form_data[:email]} exists in our system already - please try to login"}
    return erb :"login", :locals => {:register => true, 
                                     :form_data => form_data, 
                                     :errors => errors}
  end
  
  user_details.hash_password()
  user = User.new(user_details) 
  user.login()
  $user_repository.store(user)
    
  session[:authentication_id] = user.session_id
  erb :thanks
end

post '/login' do
  redirect '/' if session[:authentication_id]
  form_data = params[:data]
  validator = LoginValidator.new
  validation_info = validator.validate(form_data)
  if(validation_info.has_errors())
    return erb :"login", :locals => {:login => true, 
                                     :form_data => form_data, 
                                     :errors => validation_info.errors}
  end
  
  user_details = CustomUserAuthDetails.new(form_data[:email], form_data[:password])
  user_details.hash_password()  
  user = $user_repository.get_user_with(user_details)
  if user.nil?
    errors = {:invalidLogin => "Login failed - please try again"}
    return erb :"login", :locals => {:login => true, 
                                     :form_data => form_data, 
                                     :errors => errors}
  end
  
  user.login()
  $user_repository.store(user)
  session[:authentication_id] = user.session_id  
  erb :thanks
end

get '/logout' do
  user_session_id = session[:authentication_id]
  user = $user_repository.get_by_session_id(user_session_id)
  user.logout 
  session[:authentication_id] = nil
  $user_repository.store(user)
  redirect '/'
end

get_or_post '/auth/:auth_type/callback' do
  auth = request.env['omniauth.auth']
  user_id = auth['uid']
  provider = auth['provider']
  user_info = auth['info']
  
  user_details = UserAuthDetails.new(user_id, provider, user_info)
  user = $user_repository.get_user_with(user_details)
  user = User.new(user_details) if user.nil?
  user.login()
  $user_repository.store(user)
    
  session[:authentication_id] = user.session_id
  redirect request.env['omniauth.origin'] || '/'
end


