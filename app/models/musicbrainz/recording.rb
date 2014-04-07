class Musicbrainz::Recording < Musicbrainz
  self.table_name = 'recording'
  self.inheritance_column = nil

  belongs_to :artist_credit, foreign_key: :artist_credit
  has_one :track
end
