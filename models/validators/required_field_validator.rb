
class RequiredFieldValidator
  def self.is_form_data_empty(form_data, errors)
    form_data_empty = (form_data.nil? || form_data.empty?)
    errors[:noData] = 'Please fill in the given form' if form_data_empty
    return form_data_empty
  end
  
  def self.ensure_required_fields_present(required, form_data, errors)
    form_data_empty = self.is_form_data_empty(form_data, errors)
    return if form_data_empty
    
    filled_in_fields = [] 
    form_data.each {|k,v| filled_in_fields << k if !v.strip.empty? }
    fields_not_given = required - filled_in_fields
    fields_not_given.each {|field| errors[field.to_sym] = 'this field is required'}  
  end 

  def self.ensure_fields_valid(possible_fields, form_data, errors)
    form_data_empty = self.is_form_data_empty(form_data, errors)
    return if form_data_empty
            
    invalid_fields = []
    form_data.each {|k,v| invalid_fields << k if !possible_fields.include?(k)}
    errors[:badFields] = invalid_fields.join(', ') if !invalid_fields.empty?   
  end
  
  def self.ensure_there_is_one_of(fields, form_data, errors)
    form_data_empty = self.is_form_data_empty(form_data, errors)
    return if form_data_empty
   
    field_found = false
    fields.each {|field| field_found = true if !form_data[field].nil? && !form_data[field].empty?}
    errors[:oneRequired] = "please provide one of #{fields.join(', ')}" if !field_found  
  end
end