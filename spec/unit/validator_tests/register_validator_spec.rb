require_relative '../../test_setup'
root = File.dirname(__FILE__) + '/../../../'
Dir[root + 'models/validators/*.rb'].each {|file| require file }

  
describe "registration validator" do

  before(:each) do
    @validator = RegistrationValidator.new
  end

  def should_fail_with(form_data, expected_errors)
     errors = {}
     result = @validator.validate(form_data)
     result.has_errors().should eq(true)
     result_errors = result.errors()
     
     expected_errors.each do |expected_error, message|
       result_errors[expected_error].should eq(message)
     end
  end
       
  it "should not register if email or password are missing" do
     should_fail_with({'email' => '', 'password' => ''}, 
                      {:email => 'this field is required', 
                       :password => 'this field is required'}) 
     should_fail_with({'email' => '', 'password' => 'blah'}, {:email => 'this field is required'}) 
     should_fail_with({'email' => 'blah', 'password' => ''}, {:password => 'this field is required'}) 
   end

   it "should not register if email is in the incorrect format" do
     should_fail_with({'email' => 'blah blah balah', 'password' => 'userPassword'},
                      {:invalidEmailAddress => "The following email addresses are invalid: 'blah blah balah'"})
   end
   
end
