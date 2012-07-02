require_relative 'user_auth_details'
require_relative 'custom_auth_details'


class UserAuthDetailsFactory
  
  def self.create_from_hash(user_auth_hash)
    provider = user_auth_hash['provider']
    return CustomUserAuthDetails.from_hash(user_auth_hash) if provider == 'custom'
    return UserAuthDetails.from_hash(user_auth_hash)   
  end
  
end