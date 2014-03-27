class Musicbrainz::Track < Musicbrainz
  include Tire::Model::Search
  include Tire::Model::Callbacks
  include Indexing::TrackIndex

  belongs_to :artist_credit, foreign_key: :artist_credit

  belongs_to :artist_credit_name, foreign_key: :artist_credit, primary_key: :artist_credit
  has_one :artist, through: :artist_credit_name

  belongs_to :medium, foreign_key: :medium
  has_one :release, through: :medium

  self.table_name = 'track'
  self.inheritance_column = nil
end
