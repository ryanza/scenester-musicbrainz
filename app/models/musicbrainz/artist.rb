class Musicbrainz::Artist < Musicbrainz
  include Tire::Model::Search
  include Tire::Model::Callbacks
  include Indexing::ArtistIndex
end
