require "rails_helper"

RSpec.describe Movie, type: :model do
  it "has none to begin with" do
    expect(Movie.count).to eq 0
  end

  it "has one after adding one" do
    create :movie
    expect(Movie.count).to eq 1
  end

  it "has none after one was created in a previous example" do
    expect(Movie.count).to eq 0
  end

  it "is valid with valid attributes" do
    movie = build :movie
    expect(movie).to be_valid
  end

  it "is not valid without a name" do
    movie = build :movie, name: nil
    expect(movie).to_not be_valid
  end

  it "is not valid without info" do
    movie = build :movie, info: nil
    expect(movie).to_not be_valid
  end

  it "is not valid with too long name" do
    movie = build :movie, name: "a" * (Settings.movies.name_max_length + 1)
    expect(movie).to_not be_valid
  end

  it "is not valid with too long info" do
    movie = build :movie, info: "a" * (Settings.movies.info_max_length + 1)
    expect(movie).to_not be_valid
  end
end
