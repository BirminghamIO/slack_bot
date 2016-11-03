class Discourse
  extend Forwardable

  def initialize
    @client = DiscourseApi::Client.new(
      ENV['DISCOURSE_URL'],
      ENV['DISCOURSE_API_KEY'],
      ENV['DISCOURSE_API_USERNAME']
    )
  end

  def_delegators :client, :latest_topics, :hot_topics, :search

  private

  attr_reader :client
end
