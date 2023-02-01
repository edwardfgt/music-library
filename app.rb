require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

# We need to give the database name to the method `connect`.
class Application
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io 
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    @io.puts "Welcome to the music library manager:"
    @io.puts "What would you like to do?
    1 - List all albums
    2 - List all artists"

    input = @io.gets.chomp

    if input == "1"
      @io.puts "Here is the list of albums:"
      @album_repository.all.each do |album|
        @io.puts "* #{album.id} - #{album.title}"
      
      end
    end

    if input == "2"
      @io.puts "Here is the list of artists:"
      @artist_repository.all.each do |artist|
        @io.puts "* #{artist.id} - #{artist.name}"
      end
    end

  end

end


if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end