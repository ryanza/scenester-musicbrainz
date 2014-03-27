class Musicbrainz::Release < Musicbrainz
  self.table_name = 'release'
  self.inheritance_column = nil

  has_many :mediums, foreign_key: :release
  has_many :tracks, through: :mediums

  belongs_to :artist_credit_name, foreign_key: :artist_credit, primary_key: :artist_credit
  has_one :artist, through: :artist_credit_name
end
