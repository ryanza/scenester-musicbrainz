class Musicbrainz::Track < Musicbrainz
  include Tire::Model::Search
  include Tire::Model::Callbacks
  include Indexing::TrackIndex
  include Concerns::TrackAttributes

  scope :include_associations, -> {includes(:recording, {medium: :release}, {artist_credit_name: {artist: :artist_aliases}})}

  belongs_to :recording, foreign_key: :recording

  # do not need - don't want to leave because ES loads all relationships when indexing
  #belongs_to :artist_credit, foreign_key: :artist_credit

  belongs_to :artist_credit_name, foreign_key: :artist_credit, primary_key: :artist_credit
  has_one :artist, through: :artist_credit_name

  belongs_to :medium, foreign_key: :medium
  has_one :release, through: :medium

  self.table_name = 'track'
  self.inheritance_column = nil

  def self.search(search, page, per_page)
    Tire.search(index_name, page: page) do
      size per_page
      query{string search}
    end.results
  end

end
