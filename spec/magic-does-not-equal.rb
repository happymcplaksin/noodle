require_relative 'spec_helper'

describe 'Noodle' do
  it "should allow finding by @TERM=VALUE and -TERM=VALUE" do
    put '/nodes/xoxo.example.com', '{"params":{"ilk":"host","status":"enabled","site":"jupiter", "justfora":"test","project":"hr","prodlevel":"dev"}}'
    assert_equal last_response.status, 201
    put '/nodes/nono.example.com', '{"params":{"ilk":"host","status":"enabled","site":"jupiter", "justfora":"test","project":"hr","prodlevel":"dev"}}'
    assert_equal last_response.status, 201
    put '/nodes/oooo.example.com', '{"params":{"ilk":"host","status":"enabled","site":"uranus", "justfora":"test","project":"hr","prodlevel":"dev"}}'
    assert_equal last_response.status, 201
    Noodle::NodeRepository.repository.refresh_index!

    get '/nodes/_/@site=jupiter%20justfora=test'
    assert_equal last_response.status, 200
    assert_equal last_response.body, "oooo.example.com\n"

    get '/nodes/_/-site=jupiter%20justfora=test'
    assert_equal last_response.status, 200
    assert_equal last_response.body, "oooo.example.com\n"
  end
end

