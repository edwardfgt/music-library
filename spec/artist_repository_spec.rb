require "artist_repository"

def reset_students_table
  seed_sql = File.read('spec/seeds_artist.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe ArtistRepository do

  before(:each) do
    reset_students_table
  end

  it "returns the list of artists" do

    repo = ArtistRepository.new
    artists = repo.all
    expect(artists.length).to eq 2
    expect(artists.first.id).to eq "1"
    expect(artists.first.name).to eq "Pixies"
  end
end