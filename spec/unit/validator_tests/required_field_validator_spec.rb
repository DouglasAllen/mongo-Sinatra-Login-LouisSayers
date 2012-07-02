require_relative '../../test_setup'
require_relative '../../../models/validators/required_field_validator'

describe "required field validator" do

  before(:each) do
    @validator = RequiredFieldValidator
    @possible_fields = ['title', 'firstName', 'lastName', 'email', 'homePhone', 'mobilePhone']
    @required = ['title', 'firstName', 'lastName', 'email', 'mobilePhone']
  end
  
  it "should give an error if there is no form data when checking if required fields are present" do
    form_data = {}
    errors = {}
    @validator.ensure_required_fields_present(@required, form_data, errors)
    errors.length.should eq(1)
    errors[:noData].should eq('Please fill in the given form')
  end

  it "should give an error if there is no form data when ensuring all fields are valid" do
    form_data = {}
    errors = {}
    @validator.ensure_fields_valid(@possible_fields, form_data, errors)
    errors.length.should eq(1)
    errors[:noData].should eq('Please fill in the given form')
  end

  it "should give an error if there is no form data when checking there is one of a list" do
    form_data = {}
    errors = {}
    @validator.ensure_there_is_one_of(['one', 'two'], form_data, errors)
    errors.length.should eq(1)
    errors[:noData].should eq('Please fill in the given form')
  end
  
  it "should validate that all the required fields are present" do
    form_data = {'title' => 'a', 'firstName'=> 'a', 'lastName'=> 'a', 
                 'email'=> 'a', 'mobilePhone'=> 'a'}
    errors = {}
    @validator.ensure_required_fields_present(@required, form_data, errors)
    errors.empty?.should eq(true)
  end
  
  it "should create an error for missing fields" do
     expected_errors = {:lastName => 'this field is required', 
                            :mobilePhone => 'this field is required'}
     form_data = {'title' => 'a', 'firstName'=> 'a', 'lastName'=> '', 
                     'email'=> 'a', 'mobilePhone'=> ''}
     errors = {}
     @validator.ensure_required_fields_present(@required, form_data, errors)
     errors.length.should eq(2)
     errors.should eq(expected_errors)
   end

   it "should create an error for fields that are required but only have whitespace as values" do
     expected_errors = {:lastName => 'this field is required', 
                            :mobilePhone => 'this field is required'}
     form_data = {'title' => 'a', 'firstName'=> 'a', 'lastName'=> '   ', 
                     'email'=> 'a', 'mobilePhone'=> '   '}
     errors = {}
     @validator.ensure_required_fields_present(@required, form_data, errors)
     errors.length.should eq(2)
     errors.should eq(expected_errors)
   end

   it "should ensure that all the given fields are valid fields" do
     form_data = {'madeup_field' => 'blah'}
     errors = {}
     @validator.ensure_fields_valid(@possible_fields, form_data, errors)
     errors.include?(:badFields).should eq(true)
     errors[:badFields].should eq('madeup_field')
   end
   
   it "should create an error if one of a number of fields is not present" do
     form_data = {'title' => 'hello', 'phoneNumber' => '', 
                  'mobileNumber' => '', 'officeNumber' => ''}
     one_required = ['phoneNumber', 'mobileNumber', 'officeNumber']
       
     errors = {}
     @validator.ensure_there_is_one_of(one_required, form_data, errors)
     errors[:oneRequired].should eq('please provide one of phoneNumber, mobileNumber, officeNumber')
   end

  it "should not create an error if one of a number of fields is present" do
       form_data = {'mobileNumber' => '078415664'}
       one_required = ['phoneNumber', 'mobileNumber', 'officeNumber']
         
       errors = {}
       @validator.ensure_there_is_one_of(one_required, form_data, errors)
       errors.include?(:oneRequired).should eq(false)
   end
   
end
