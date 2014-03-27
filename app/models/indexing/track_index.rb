module Indexing::TrackIndex
  include Indexing::ModelIndex
  extend ActiveSupport::Concern

  module TrackFields
    def do_indexes_definitions(indexable_object = self, opts = {})
      indexable_object.class_eval do
        indexes :id, type: :integer, index: :not_analyzed
      end
    end
  end

  included do
    extend Indexing::TrackIndex::TrackFields
    default_elastic_search_settings_and_mapping
    do_indexes_definitions
  end
end