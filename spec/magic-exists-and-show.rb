require_relative 'spec_helper'
require 'cgi'

describe 'Noodle' do
  it "should allow finding and showing with TERM?=" do
    put '/nodes/lolo.example.com', '{"params":{"ilk":"host","status":"enabled","site":"jupiter", "funky":"town","project":"hr","prodlevel":"dev"}}'
    assert_equal last_response.status, 201
    Noodle::NodeRepository.repository.refresh_index!

    get "/nodes/_/funky#{CGI.escape('?=')}"
    assert_equal last_response.status, 200
    assert _(last_response.body).must_include 'lolo.example.com funky=town'
  end
end

