require_relative '../spec_helper'

describe 'Home', :type => :feature do
  it 'responds with successful status' do
    visit '/'
    expect(page.status_code).to eq 200
  end

  it 'responds with a welcome message' do
    visit '/'
    expect(page).to have_content 'Hello, world'
  end
end
