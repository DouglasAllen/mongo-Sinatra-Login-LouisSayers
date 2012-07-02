

class UserAuthDetails
  
  attr_reader :user_id, :provider, :user_info_hash
  
  def initialize(user_id, provider, user_info_hash = {})
    @user_id = user_id
    @provider = provider
    @user_info_hash = user_info_hash
  end
  
  def as_hash()
    return {'user_id' => @user_id,
            'provider' => @provider,
            'user_info' => @user_info_hash}
  end

  def as_json()
    return {:user_id => @user_id,
            :provider => @provider,
            :user_info => @user_info_hash}
  end
  
  def self.from_hash(hashed_details)
    return UserAuthDetails.new( hashed_details['user_id'],
                                hashed_details['provider'],
                                hashed_details['user_info'] )
  end
  
  def ==(otherAuthDetails)
    return false if @provider != otherAuthDetails.provider
    return false if @user_id != otherAuthDetails.user_id
    return false if @user_info_hash != otherAuthDetails.user_info_hash
    return true
  end
end