class ValidationResult
  
  def initialize(errors)
    @errors = errors
  end
  
  def has_errors()
    return !@errors.empty?
  end
  
  def errors()
    return @errors
  end
end