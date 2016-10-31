require 'sinatra'
require 'appsignal/integrations/sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/json'
require 'discourse_api'
require 'dotenv'
Dotenv.load

get '/' do
  redirect 'https://birmingham.io/', 301
end

post '/' do
  json send request_action
end

private

# request processing stuff
def request_payload
  @request_payload ||= begin
    request.body.rewind
    JSON.parse request.body.read
  end
end

def request_action
  @request_action ||= request_payload['result']['action']
end

def request_parameters
  @request_parameters ||= request_payload['result']['parameters']
end

# getting data stuff
def forum_search
  format_return "Forum search for '#{request_parameters['search_term']}'"
end

def forum_latest
  format_return discourse_client.latest_topics
end

def forum_top
  format_return 'Top topics'
end

def discourse_client
  @discourse_client ||= begin
    DiscourseApi::Client.new(
        ENV['DISCOURSE_URL'],
        ENV['DISCOURSE_API_KEY'],
        ENV['DISCOURSE_API_USERNAME']
    )
  end
end

# returning data stuff
def format_return(string)
  {
      'speech':      string,
      'displayText': string,
      'source':      "birmingham.io"
  }
end
