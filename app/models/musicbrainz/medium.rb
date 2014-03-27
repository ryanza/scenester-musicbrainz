class Musicbrainz::Medium < Musicbrainz
  self.table_name = 'medium'
  self.inheritance_column = nil

  has_many :tracks, foreign_key: :medium
  belongs_to :release, foreign_key: :release
end
