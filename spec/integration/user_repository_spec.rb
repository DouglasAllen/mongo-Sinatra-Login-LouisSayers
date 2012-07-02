require_relative '../test_setup'

describe 'user repository' do
  
  before(:each) do 
    $db['users'].drop()
    
    @user_repo = UserRepository.new
    @user_info = {'name' => "louis required", 'email' => "this and the rest are optional"}
    @auth_details = UserAuthDetails.new("user_id", "provider", @user_info)
    @user = User.new(@auth_details) 
  end
  
  it 'should store and retrieve single user' do
    @user_repo.store(@user)
    retrieved_user = @user_repo.get_by_session_id(@user.session_id)
   
    retrieved_user.should == @user
  end
  
  it 'should update an existing user' do
    @user_repo.store(@user)
    @user.add_auth_details([UserAuthDetails.new("new_user_id", "new_provider", @user_info)])
    @user_repo.store(@user)
    
    retrieved_user = @user_repo.get_by_session_id(@user.session_id)
    retrieved_user.should == @user
  end
  
  it 'should retrieve an existing user based on their Custom auth details' do
    auth_details = CustomUserAuthDetails.new("lssayers@gmail.com", 'mypassword')
    user = User.new(auth_details)
    @user_repo.store(user)
    retrieved_user = @user_repo.get_user_with(auth_details)
    retrieved_user.should == user 
  end
  
  it 'should not retrieve a Custom user if their hashed password is not correct' do
    incorrect_auth_details = CustomUserAuthDetails.new("lssayers@gmail.com", 'incorrect')
    auth_details = CustomUserAuthDetails.new("lssayers@gmail.com", 'mypassword')
    user = User.new(auth_details)
    @user_repo.store(user)
    retrieved_user = @user_repo.get_user_with(incorrect_auth_details)
    retrieved_user.should == nil 
  end
  
  it 'should tell us if a user exists based on user_id and provider' do
    @user_repo.store(@user)
    @user_repo.user_exists_with(@auth_details).should == true
  end
  
  it 'should not tell us that a user exists if the provider is different' do
    @user_repo.store(@user)
    similar_user_details = UserAuthDetails.new("user_id", "custom", @user_info)
    @user_repo.user_exists_with(similar_user_details).should == false
  end
  
  it 'should retrieve an existing user by using their authentication details' do
    @user_repo.store(@user)
    retrieved_user = @user_repo.get_user_with(@auth_details)
    retrieved_user.should == @user
  end
  
  it 'should save user session state when a user logs out' do
    original_session_id = @user.session_id
    @user_repo.store(@user)
    @user.logout()
    
    @user_repo.store(@user)
    
    retrieved_user = @user_repo.get_by_session_id(original_session_id)
    retrieved_user.should == nil
  end

  
end
