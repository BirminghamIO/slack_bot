require_relative '../spec_helper.rb'

RSpec.describe Application do

  it 'should redirect to birmingham.io' do
    get '/'

    expect(last_response).to be_redirect
  end
end
