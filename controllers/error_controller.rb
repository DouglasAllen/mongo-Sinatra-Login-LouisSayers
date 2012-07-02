require_relative '../models/exceptions/invalid_registration_exception'
require_relative '../models/exceptions/invalid_session_exception'

error InvalidRegistrationStep do
  env['sinatra.error'].message
end

error InvalidSession do
  the_invalid_session = env['sinatra.error'].message
  'You have an invalid session... Please ensure that you clear your cookies and browsing history.'
end