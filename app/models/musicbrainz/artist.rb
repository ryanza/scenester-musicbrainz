class Musicbrainz::Artist < Musicbrainz
  include Tire::Model::Search
  include Tire::Model::Callbacks
  include Indexing::ArtistIndex

  self.table_name = 'artist'
  self.inheritance_column = nil
end
