require 'digest/sha1'

class CustomUserAuthDetails
  
  attr_reader :user_id, :provider, :password
  
  def initialize(user_id, password)
    @user_id = user_id
    @password = password
    @provider = 'custom'
  end
  
  def hash_password()
    @password = Digest::SHA1.hexdigest(password)
  end
  
  def as_hash()
    return {'user_id' => @user_id,
            'provider' => @provider,
            'password' => @password}
  end

  def as_json()
    return {:user_id => @user_id,
            :provider => @provider,
            :password => @password}
  end
  
  def self.from_hash(hashed_details)
    return CustomUserAuthDetails.new( hashed_details['user_id'],
                                       hashed_details['password'] )
  end
  
  def ==(otherAuthDetails)
    return false if @provider != otherAuthDetails.provider
    return false if @user_id != otherAuthDetails.user_id
    return false if @password != otherAuthDetails.password
    return true
  end
end