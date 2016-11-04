require_relative 'latest_action'
require_relative 'top_action'
require_relative 'search_action'

class IntentActioner
  def initialize(request)
    @request = request
  end

  def call
    send request.intent
  end

  def forum_latest
    LatestAction.call
  end

  def forum_top
    TopAction.call
  end

  def forum_search
    SearchAction.call(request.parameters)
  end

  private

  attr_reader :request
end
