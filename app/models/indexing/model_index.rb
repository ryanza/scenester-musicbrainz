module Indexing::ModelIndex

  module ClassMethods

    def default_elastic_search_settings_and_mapping
      num_shards = Rails.env.development? ? 1 : 5
      num_replicas = Rails.env.development? ? 0 : 1
      tire.settings number_of_shards: num_shards,
        number_of_replicas: num_replicas,
        analysis: {
          # Custom analyzers and token filters are set up here
          # Some examples below - the ngram_analyzers are made up of the es analyzers in filter
          # These used for autocomplete type stuff - Breaks words up into grams we can use at index time
          # And query these words with a standard search
          :analyzer => {
            :search_ngram_analyzer => {
              "type" => "custom",
              "tokenizer" => "standard",
              "filter" => [ "standard", "lowercase"]
            },
            :index_ngram_analyzer => {
               "type" => "custom",
               "tokenizer" => "standard",
               "filter" => [ "standard", "lowercase", "our_ngram" ]
            },
          },
          :filter => {
            :our_ngram  => {
              "type"     => "edgeNGram",
              "max_gram" => 10,
              "min_gram" => 1
            }
          }
        }
      tire.mapping :_source => { :compress => true }, :_all => { :enabled => true }
    end

    def query_elastic_search(all_params = {})
      per_page = all_params[:per_page] || 10
      page = all_params[:page] || 1
      params = all_params.except(:page, :per_page)
      models_to_eager_load = defined?(self::MODELS_TO_EAGER_LOAD) ? self::MODELS_TO_EAGER_LOAD : []

      results = Tire.search(index_name, {load: {include: models_to_eager_load} ,page: page}) do |s|
        s.size per_page
        if self.respond_to?(:build_query)
          self.build_query(s, params)
        end
        # s.sort {}
      end.results

    end
  end
end
