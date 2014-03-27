class Musicbrainz::Artist < Musicbrainz
  self.table_name = 'artist'
  self.inheritance_column = nil

  has_many :artist_credit_names, foreign_key: :artist
  has_many :releases, through: :artist_credit_names
  has_many :tracks, through: :artist_credit_names
end
