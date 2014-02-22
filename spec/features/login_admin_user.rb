require 'spec_helper'

describe 'admin signin process' , type: :api do

  it 'should something' do
    # @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("username:password")
    visit(root)
    # response.should be_fail
    expect(page).to have_content 'Success'
  end
end
