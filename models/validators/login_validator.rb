require_relative 'validation_result'
require_relative 'required_field_validator'
require_relative 'email_validator'

class LoginValidator
  def initialize
      @possible_fields = ['email', 'password']
      @required = ['email', 'password']
    end 
    
    def validate(form_data)
      errors = {}
      RequiredFieldValidator.ensure_required_fields_present(@required, form_data, errors)
      RequiredFieldValidator.ensure_fields_valid(@possible_fields, form_data, errors)
      EmailValidator.ensure_email(['email'], form_data, errors)
      return ValidationResult.new(errors)
    end
end