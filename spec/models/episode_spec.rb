require "rails_helper"

RSpec.describe Episode, type: :model do
  before(:each) do
    @tv_show = create :tv_show
    @season = create :season
  end

  it "is valid with valid attributes" do
    episode = build :episode
    expect(episode).to be_valid
  end

  it "is not valid without an episode number" do
    episode = build :episode, episode_number: nil
    expect(episode).to_not be_valid
  end

  it "is not valid without info" do
    episode = build :episode, info: nil
    expect(episode).to_not be_valid
  end

  it "is not valid with too long info" do
    episode = build :episode, info: "a" * (Settings.episodes.info_max_length + 1)
    expect(episode).to_not be_valid
  end

  it "is not valid with duplicate episode number" do
    @season.episodes.create episode_number: 1, info: "abc"
    episode = @season.episodes.new episode_number: 1, info: "def"
    expect(episode).to_not be_valid
  end
end
