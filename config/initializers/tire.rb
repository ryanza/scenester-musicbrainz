TIRE_MODELS = []

Tire.configure do
  logger STDOUT, :level => :warn  if Rails.env.development?
  logger STDOUT, :level => :warn  if (Rails.env.production? || Rails.env.preproduction? || Rails.env.staging?)

  if %{production staging}.include?(Rails.env)
    url ENV['ELASTICSEARCH_URL']
  end

  INDEX_VERSION = ENV['ELASTICSEARCH_INDEX_VERSION'] || 0
  index_prefix = "#{Rails.application.class.parent_name.downcase}_#{Rails.env.to_s.downcase}_#{INDEX_VERSION}"
  Tire::Model::Search.index_prefix(index_prefix)
end
