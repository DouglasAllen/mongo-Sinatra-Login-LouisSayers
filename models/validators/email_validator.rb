
class EmailValidator
    
  def self.ensure_email(email_fields, form_data, errors)
    email_regex = /\A[\w\._%-]+@[\w\.-]+\.[a-zA-Z]{2,4}\z/
    return if form_data.empty?
    return if email_fields.empty?
    invalid_emails = []
    
    email_fields.each do |field|
      email = form_data[field]
      invalid_emails << "'#{email}'" if email.nil? || email.empty? || !email_regex.match(email)
    end
    
    unless(invalid_emails.empty?)
      errors[:invalidEmailAddress] = "The following email addresses are invalid: " +
                                     invalid_emails.join(', ')
    end
  end 

end