require_relative 'controller_helpers/user_helpers'

get '/' do
  erb :home
end

get '/authorized_url' do
  puts "in the url"
  redirect '/'
  redirect_if_not_authorised(request, session)
  return 'successfully authorized'
end