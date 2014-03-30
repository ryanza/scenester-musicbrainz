class Musicbrainz::ArtistAlias < Musicbrainz
  self.table_name = 'artist_alias'
  self.inheritance_column = nil

  belongs_to :artist, foreign_key: :artist
end
