require 'spec_helper'

describe Api::V1::MusicbrainzController do

  describe "GET 'search'" do
    it "returns http success" do
      get 'search'
      expect(response).to be_success
    end
  end

end
