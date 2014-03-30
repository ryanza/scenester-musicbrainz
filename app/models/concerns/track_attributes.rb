module Concerns::TrackAttributes
  extend ActiveSupport::Concern

  def recording_gid
    self.recording.gid
  end

  def artist_name
    if self.artist_credit_name.present?
      self.artist_credit_name.name
    end
  end

  def artist_aliases
    if self.artist_credit_name.present? && self.artist_credit_name.artist.present?
      self.artist_credit_name.artist.artist_aliases.to_a.collect(&:name)
    end
  end

  def albumn_name
    if self.medium.present? && self.medium.release.present?
      self.medium.release.name
    end
  end

end
