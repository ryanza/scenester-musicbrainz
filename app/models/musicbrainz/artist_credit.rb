class Musicbrainz::ArtistCredit < Musicbrainz
  self.table_name = 'artist_credit'
  self.inheritance_column = nil

  has_one :track, foreign_key: :artist_credit
  has_one :artist_credit_name, foreign_key: :artist_credit
end
