node(:tracks){
  @tracks.results.map{ |t|
    {
      gid: t.recording_gid,
      name: t.name,
      albumn_name: t.albumn_name,
      artist_name: t.artist_name,
      artist_aliases: t.artist_aliases
    }
  }
}
node(:page){@tracks.current_page}
node(:total_pages){@tracks.total_pages}
