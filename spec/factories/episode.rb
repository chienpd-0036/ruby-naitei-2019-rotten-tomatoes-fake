FactoryBot.define do
  factory :episode do
    episode_number {1}
    info {"Episode 1"}
    association :season
  end
end
