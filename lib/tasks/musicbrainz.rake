namespace :musicbrainz do
  desc "Add which_id to existing versions"
  task :sync => [:environment] do |t, args|
    file_path = Rails.root.join('config','music_brains_last_synced_with_elastic_search.txt')
    last_synced_at = nil
    begin
      if File.exist?(file_path)
        last_synced_at = DateTime.parse(File.read(file_path))
      end
    rescue
      log("Something went wrong reading the file. Will ignore and start again.")
    end

    synced_at = DateTime.now
    query = Musicbrainz::Track.include_associations.where('last_updated <= ?', synced_at)
    query = query.and('last_updated > ?', last_synced_at) if last_synced_at.present?

    count = 0
    query.find_in_batches(batch_size: SYNC_BATCH_SIZE) do |tracks|
      #For checking memory usage
      log ObjectSpace.count_objects.to_yaml
      log("Got a batch of #{tracks.size} tracks. Creating json and updating in elastic search.")
      bulk_update = []
      tracks.each do |track|
        json = JSON.parse(track.to_indexed_json)
        bulk_update << {id: track.id, type: Musicbrainz::Track.document_type, doc: json, doc_as_upsert: true}
      end
      Musicbrainz::Track.index.bulk :update, bulk_update
    end

    # Write last updated_at to file
    log("Finished: writing synced_at to file.")
    File.open(file_path, 'w'){ |f| f.write(synced_at.to_s)}
  end

  def log(message)
    puts message
    Rails.logger.info(message)
  end
end
