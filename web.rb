require 'sinatra'
require 'appsignal/integrations/sinatra'

get '/' do
  "Hello, world"
end

post '/' do
  "How's this?"
end
