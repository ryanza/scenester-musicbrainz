class Musicbrainz::ArtistCreditName < Musicbrainz
  self.table_name = 'artist_credit_name'
  self.inheritance_column = nil

  belongs_to :artist_credit, foreign_key: :artist_credit
  belongs_to :artist, foreign_key: :artist

  belongs_to :release, foreign_key: :artist_credit, primary_key: :artist_credit
  belongs_to :track, foreign_key: :artist_credit, primary_key: :artist_credit
end
