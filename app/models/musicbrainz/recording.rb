class Musicbrainz::Recording < Musicbrainz
  self.table_name = 'recording'
  self.inheritance_column = nil

  has_one :track
end
