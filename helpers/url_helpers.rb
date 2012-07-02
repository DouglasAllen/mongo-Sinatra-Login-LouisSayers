def get_return_url(request)         
  query_string = ""
  if(request.env['QUERY_STRING'])
    query_string = "?#{request.env['QUERY_STRING']}"
  end
  return "#{request.env['PATH_INFO']}#{query_string}"
end
