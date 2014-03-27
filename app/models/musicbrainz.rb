class Musicbrainz < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "musicbrainz_database_#{Rails.env}"
end
