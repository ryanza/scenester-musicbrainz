ScenesterMusicbrainz::Application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get 'search' => 'musicbrainz#search'
    end
  end
end
