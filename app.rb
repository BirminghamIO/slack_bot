require 'rubygems'
require 'bundler/setup'
require 'dotenv'
require 'slack'
require 'luis'
Dotenv.load

Slack.configure do |config|
  config.token        = ENV['SLACK_API_TOKEN']
  config.logger       = Logger.new(STDOUT)
  config.logger.level = Logger::INFO
  fail 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

Luis.configure do |config|
  config.id               = ENV['LUIS_APP_ID']
  config.subscription_key = ENV['LUIS_SUBSCRIPTION_KEY']
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts "Successfully connected, welcome '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
end

client.on :message do |data|
  puts data

  case data.text
    when 'bot hi' then
      client.typing channel: data.channel
      client.message channel: data.channel, text: "Hi <@#{data.user}>!"
    when /bot/ then
      client.typing channel: data.channel
      client.message channel: data.channel, text: "Sorry <@#{data.user}>, what?"
    else
      query = Luis.query(data.text)
      client.typing channel: data.channel
      client.message channel: data.channel, text: "It looks like your intent is #{query.intents.first.intent}, <@#{data.user}>"
  end
end

client.on :close do |_data|
  puts 'Connection closing, exiting.'
end

client.on :closed do |_data|
  puts 'Connection has been disconnected.'
end

client.start!
