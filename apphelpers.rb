require 'sinatra'

helpers do
    def partial (template, locals = {})
      erb(template, :layout => false, :locals => locals)
    end
end

def get_or_post(path, opts={}, &block)
  get(path, opts, &block)
  post(path, opts, &block)
end
