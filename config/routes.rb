ScenesterMusicbrainz::Application.routes.draw do
  get "musicbrainz/search"
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get 'search' => 'musicbrainz#search'
    end
  end
end
