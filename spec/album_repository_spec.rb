require 'album_repository'

describe AlbumRepository do
  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_albums_table
  end

  it "returns the list of albums" do
    repo = AlbumRepository.new
    albums = repo.all
    expect(albums.length).to eq 2
    expect(albums.first.title).to eq "Bossanova"
  end

  it "returns a single album object based on criteria " do
    repo = AlbumRepository.new
    albums = repo.find(1)
    expect(albums.title).to eq "Bossanova"
    albums = repo.find(2)
    expect(albums.release_year).to eq "2002"
  end

  it "creates a new item record in the database" do
    repo = AlbumRepository.new
    album = Album.new
    album.title = 'Trompe le Monde'
    album.release_year = 1991
    album.artist_id = 1

    repo.create(album)
    all_albums = repo.all
    expect(all_albums).to include(
      have_attributes(
        title: 'Trompe le Monde',
        release_year: '1991'
      )
    )

  end
end