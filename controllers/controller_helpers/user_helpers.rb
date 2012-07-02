require_relative '../../models/user'
require_relative '../../repository/user_repository'
require_relative '../../models/exceptions/invalid_session_exception'
require_relative '../../helpers/url_helpers'

def get_user_from(session)
  user_session_id = session[:authentication_id]
  redirect "/login?return_url=#{return_url}" if !user_session_id || user_session_id.empty?
  
  user = $user_repository.get_by_session_id(user_session_id)
  raise InvalidSession, user_session_id if user.nil?
  return user
end

def get_user_list()
  return $user_repository.get_user_list()
end


def redirect_if_not_authorised(request, session)
  return_url = get_return_url(request)
  user_session_id = session[:authentication_id]
  redirect "/login?return_url=#{return_url}" if !user_session_id || user_session_id.empty?
end
