require_relative '../test_setup'

describe 'user auth details' do

  before(:each) do
    user_info = {:name => "louis required", :email => "this and the rest are optional"}
    @auth_details = UserAuthDetails.new("user_id", "provider", user_info)
    
    @hashed_details = {'user_id' => 'user_id', 
                       'provider' => 'provider', 
                       'user_info' => user_info}
  end
  
  it 'should create a hash of itself' do
    @auth_details.as_hash().should eq(@hashed_details)
  end
  
  it 'should create user auth details from a hash' do
    user_auth_details = UserAuthDetails.from_hash(@hashed_details)
    user_auth_details.should eq(@auth_details)
  end
  
end