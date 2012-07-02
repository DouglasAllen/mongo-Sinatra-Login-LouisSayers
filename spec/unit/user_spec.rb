require_relative '../test_setup'

describe 'user' do
 
  before(:each) do
    @user_info = {:name => "louis required", :email => "this and the rest are optional"}
    @auth_details = UserAuthDetails.new("user_id", "provider", @user_info)
    @user = User.new(@auth_details)
    @user_as_hash = {'session_id' => @user.session_id,
                     'user_auth_details' => [{'user_id' => 'user_id', 
                                               'provider' => 'provider', 
                                               'user_info' => @user_info}],
                     }
  end
  
  it 'should generate a unique session id for each user' do
    auth_details2 = UserAuthDetails.new("user2_id", "provider", @user_info)
    user2 = User.new(auth_details2)
    
    @user.session_id.should_not eq(user2.session_id)
  end
  
  it 'should create a hash of itself' do
    hashed_user = @user.as_hash()
    hashed_user.should eq(@user_as_hash)
  end
  
  it 'should return nil if given an empty hash to create itself from' do
    user_from_hash = User.from_hash({})
    user_from_hash.should eq(nil)
  end

  it 'should return nil if given nil to create itself from' do
    user_from_hash = User.from_hash(nil)
    user_from_hash.should eq(nil)
  end
  
  it 'should create itself from a hash of itself' do
    user_from_hash = User.from_hash(@user_as_hash)
    user_from_hash.should == @user
  end
  
  it 'should wipe session info when logging out' do
    @user.session_id.should_not eq(nil)
    @user.logout()
    @user.session_id.should eq('')
  end
  
  it 'should not modify existing session info upon login' do
    existing_session_id = @user.session_id
    @user.session_id.should_not eq(nil)
    
    @user.login()
    @user.session_id.should eq(existing_session_id)
  end

  it 'should create a session id upon login if one does not exist' do
    @user.logout()
    @user.login()
    @user.session_id.should_not eq(nil  )
  end
  
end