require 'spec_helper'

describe Musicbrainz::Track do
  describe '.api_search' do
    context 'search on track name' do
      before(:all) do
        @track1 = create(:track, name: "Cool song", artist_credit: 1)
        @track2 = create(:track, name: "lame sonG", artist_credit: 1)
        Musicbrainz::Track.index.refresh #easier than waiting for callback index to finish
      end
      it{expect(Musicbrainz::Track.api_search("song").count).to eq(2)}
    end
  end
end
