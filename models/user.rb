require_relative 'user_auth_details_factory'

class User
  
  attr_reader :session_id, :user_auth_details
  
  def initialize(user_auth_details)
    @user_auth_details = [user_auth_details]
    @session_id = generate_session()
  end
  
  def add_auth_details(auth_details)
    return if auth_details.nil? || auth_details.empty?
    @user_auth_details.concat(auth_details)
  end
  
  def login()
    @session_id = generate_session() if @session_id.nil? || @session_id.empty?
  end
  
  def logout()
    @session_id = ''
  end
  
  def as_hash()
    return { 'session_id' => @session_id,
             'user_auth_details' => @user_auth_details.map{|detail| detail.as_hash()},
           }
  end

  def as_json()
    return { :session_id => @session_id,
             :user_auth_details => @user_auth_details.map{|detail| detail.as_json()},
           }
  end
  
  def self.from_hash(hashed_user)
    return nil if hashed_user.nil? || hashed_user.empty? 
    hashed_user_auth_details = hashed_user['user_auth_details']
    user_auth_details = hashed_user_auth_details.map{|details| UserAuthDetailsFactory.create_from_hash(details)}
    first_auth_details = user_auth_details.slice!(0)
        
    new_user = User.new(first_auth_details)
    new_user.add_auth_details(user_auth_details)
    new_user.instance_variable_set(:@session_id, hashed_user['session_id'])
    return new_user
  end
  
  def ==(another_user)
     return false if @session_id != another_user.session_id
     return false if @user_auth_details.length != another_user.user_auth_details.length
          
     @user_auth_details.each do |auth_detail|
        return false if !another_user.user_auth_details.any? {|detail| detail == auth_detail}
     end
     
     return true    
  end
  
  private
  
  def generate_session 
    return Digest::MD5.hexdigest("#{@user_auth_details.first().user_id.to_s}#{Time.now}").to_s()
  end
  
end