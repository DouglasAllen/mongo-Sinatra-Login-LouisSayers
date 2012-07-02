require_relative '../test_setup'

describe 'authorization' do
  include Rack::Test::Methods
  include CustomHtmlMatchers
  
  url_that_requires_authentication = '/authorized_url'
  
  it "should show login prompt if not authorized" do
    puts "about to get the url"
    get url_that_requires_authentication, rack_env = {:session => {}}
    puts "got the url"
    follow_redirect!
    
    last_response.should be_ok
    last_response.should have_tag_with_attr(:class => "sign_in_box span4")
  end

  it "should not show login prompt if authorized" do
    session_info = {:authentication_id => "2kjsdlkfja323423adfas"}
    get url_that_requires_authentication, rack_env = {:session => session_info}
    last_response.should_not have_tag_with_attr(:class => "sign_in_box span4")
  end
    
end
