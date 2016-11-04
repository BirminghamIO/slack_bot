class RequestParser
  def initialize(request)
    request.body.rewind
    @data = JSON.parse request.body.read
  end

  def intent
    data['result']['action']
  end

  def entities
    data['result']['parameters']
  end

  private

  attr_reader :data
end
