require_relative '../spec_helper.rb'

RSpec.describe Application do

  context 'GET /' do
    subject { get '/' }

    it 'redirects to birmingham.io' do
      subject

      expect(last_response).to be_redirect
    end
  end
end
