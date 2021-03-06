require_relative 'spec_helper'

describe 'Noodle' do
  it "should allow finding by 'TERM1=~VALUE1 TERM2=~VALUE2'" do
    put '/nodes/vovo.example.com', '{"params":{"ilk":"host","status":"enabled","site":"neptune","project":"hr","prodlevel":"dev"}}'
    assert_equal last_response.status, 201
    put '/nodes/toto.example.com', '{"params":{"ilk":"host","status":"enabled","site":"neptune","prodlevel":"prod","project":"hr"}}'
    assert_equal last_response.status, 201

    Noodle::NodeRepository.repository.refresh_index!

    get '/nodes/_/site=~nept%20prodlevel=~pro'
    assert_equal last_response.status, 200
    assert_equal last_response.body, "toto.example.com\n"
  end
end

