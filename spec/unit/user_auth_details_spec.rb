require_relative '../test_setup'

describe 'Custom user auth details' do

  before(:each) do
    @auth_details = CustomUserAuthDetails.new("email", "apple")
    
    @hashed_details = {'user_id' => 'email', 
                       'provider' => 'custom', 
                       'password' => 'apple'}
  end
  
  it 'should create a hash of itself' do
    @auth_details.as_hash().should eq(@hashed_details)
  end
  
  it 'should create user auth details from a hash' do
    user_auth_details = CustomUserAuthDetails.from_hash(@hashed_details)
    user_auth_details.should eq(@auth_details)
  end
  
  it 'should hash the password' do
    apple_hashed = 'd0be2dc421be4fcd0172e5afceea3970e2f3d940'
    @auth_details.hash_password()
    @auth_details.password.should == apple_hashed
  end
  
end