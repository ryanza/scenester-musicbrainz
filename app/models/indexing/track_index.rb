module Indexing::TrackIndex
  include Indexing::ModelIndex
  extend ActiveSupport::Concern

  module TrackFields
    def do_indexes_definitions(indexable_object = self, opts = {})
      indexable_object.class_eval do
        indexes :id, type: :integer, index: :not_analyzed
        indexes :recording_gid, as: 'self.recording_gid', type: :string, index: :not_analyzed
        indexes :name, type: :string, search_analyzer: :standard, index_analyzer: :standard
        indexes :albumn_name, as: 'self.albumn_name', type: :string, search_analyzer: :standard, index_analyzer: :standard
        indexes :artist_name, as: 'self.artist_name', type: :string, search_analyzer: :standard, index_analyzer: :standard
        indexes :artist_aliases, as: 'self.artist_aliases', type: :string, search_analyzer: :standard, index_analyzer: :standard
      end
    end
  end

  included do
    extend Indexing::TrackIndex::TrackFields
    default_elastic_search_settings_and_mapping
    do_indexes_definitions
  end
end
