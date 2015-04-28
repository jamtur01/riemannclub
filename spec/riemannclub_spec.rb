require 'spec_helper'

describe RiemannClub::Application do

  describe "GET '/'" do
    it "should return the index page." do
      get '/'
      last_response.should be_ok
    end
  end
end
