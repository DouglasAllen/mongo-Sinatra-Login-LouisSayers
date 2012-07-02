
class UserRepository
  
  def initialize()
    @user_collection = $db['users']
  end
  
  def store(user)
    if(there_is_no_user(user))
      @user_collection.insert(user.as_hash())
      return
    end
    @user_collection.update(user_query_criteria(user), user.as_hash())
  end

  def get_user_list() 
    users = @user_collection.find({'user_auth_details.provider' => 'custom'})
    results = []
    users.each do |user_hash|
      results << User.from_hash(user_hash)
    end  
    return results
  end
    
  def get_by_session_id(user_session_id) 
    user_hash = @user_collection.find_one(:session_id => user_session_id)
    return User.from_hash(user_hash)
  end
  
  def get_user_with(user_auth_details)
    user_hash = retrieve_user_with(user_auth_details)
    return User.from_hash(user_hash)
  end
  
  def user_exists_with(user_auth_details)
    user = @user_collection.find_one({'user_auth_details.user_id' => "#{user_auth_details.user_id}",
                                      'user_auth_details.provider' => "#{user_auth_details.provider}"})
    return !user.nil?
  end
  
  private
  
  def there_is_no_user(user)
    user_auth_details = user.user_auth_details.first()
    return retrieve_user_with(user_auth_details).nil?
  end
  
  def retrieve_user_with(user_auth_details)
    return  @user_collection.find_one(user_query(user_auth_details))
  end
  
  def user_query_criteria(user)
    user_auth_details = user.user_auth_details.first()
    return user_query(user_auth_details)
  end
  
  def user_query(user_auth_details)
    query = {'user_auth_details.user_id' => "#{user_auth_details.user_id}",
            'user_auth_details.provider' => "#{user_auth_details.provider}"}
    
    if(user_auth_details.provider == 'custom')
      query['user_auth_details.password'] = "#{user_auth_details.password}"
    end
    
    return query
  end
  
end