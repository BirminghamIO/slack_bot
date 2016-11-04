require 'rubygems'
require 'bundler'

require_relative '../lib/discourse'

Bundler.require

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

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
    format_return discourse.latest_topics
  end

  def forum_top
    format_return 'Top topics'
  end

  # returning data stuff
  def format_return(string)
    {
      'speech':      string,
      'displayText': string,
      'source':      "birmingham.io"
    }
  end
end
