FactoryGirl.define do
  factory :track, :class => Musicbrainz::Track do
    name {Faker::Lorem.sentence(2)}
    gid {UUID.generate}
    position {Faker::Number.digit}
    number {Faker::Number.digit}

    association :artist_credit_name
    association :medium
    association :recording

    after(:create) do |track, evaluator|
      track.update_index
    end

    # Dont care
    artist_credit {rand(100)}
  end

  factory :recording, :class => Musicbrainz::Recording do
    gid {UUID.generate}
    name {Faker::Lorem.sentence(2)}
    association :artist_credit
  end

  factory :artist_credit_name, :class => Musicbrainz::ArtistCreditName do
    position {Faker::Number.digit}
    name {Faker::Lorem.sentence(2)}

    association :artist
    association :artist_credit
  end

  factory :artist_credit, :class => Musicbrainz::ArtistCredit do
    name {Faker::Name.name}
    artist_count {Faker::Number.digit}
  end

  factory :artist, :class => Musicbrainz::Artist do
    name {Faker::Name.name}
    sort_name {"#{name}"}
    gid {UUID.generate}

    ignore do
      alias_count 5
    end
    after(:create) do |artist, evaluator|
      create_list(:artist_alias, evaluator.alias_count, artist: artist)
    end
  end

  factory :artist_alias, :class => Musicbrainz::ArtistAlias do
    name {Faker::Name.name}
    sort_name {"#{name}"}
  end

  factory :medium, :class => Musicbrainz::Medium do
    position {rand(20)}
    association :release
  end

  factory :release, :class => Musicbrainz::Release do
    gid {UUID.generate}
    name {Faker::Lorem.sentence(2)}

    association :artist_credit

    #Things we dont care about
    release_group {Faker::Number.number(2)}
  end

end
