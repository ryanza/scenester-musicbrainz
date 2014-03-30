namespace :es do
  task :drop => :environment do
    TIRE_MODELS.each do |model|
      model.constantize.tire.index.delete
    end
  end

  desc "Refresh the ElasticSearch index for the current environment"
  task :refresh => :environment do
    TIRE_MODELS.each do |model|
      model.constantize.tire.index.refresh
    end
  end

  desc "Create the ElasticSearch index for the current environment"
  task :create => :environment do
    TIRE_MODELS.each do |model|
      model_s = model.constantize
      puts model_s
      model_s.create_elasticsearch_index
      # use model.create_elasticsearch_index over model.tire.index.create
      # model.create_elasticsearch_index creates it with the mapping, model.tire.index.create creates a blank index
    end
  end

  desc "DROP ALL INDEX FROM EVERYTHING !!!!"
  task :drop_all => :environment do
    HTTParty.delete("#{ELASTIC_SEARCH_URL}/_all/")
  end

  desc "Bulk reindex of all or selected models"
  task :bulk_reindex, [:models] => :environment do |t,args|
    models_to_reindex = args[:models].present? ? args[:models].gsub(' ', '').split(',') : TIRE_MODELS
    models_to_reindex.map!(&:constantize)
    models_to_reindex.each do |model|
      model.tire.index.delete
      model.create_elasticsearch_index
      model.find_in_batches(batch_size: 500) do |batch|
        model.tire.index.import batch
      end
    end
  end
end
