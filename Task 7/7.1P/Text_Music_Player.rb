require './input_functions'
module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

$genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Album
	attr_accessor :title, :artist, :image, :genre, :tracks

	def initialize (title, artist, image, genre, tracks)
		@title = title
		@artist = artist
		@image = image
		@genre = genre
    @tracks = tracks
	end
end

class Track
	attr_accessor :name, :location

	def initialize (name, location)
		@name = name
		@location = location
	end
end 

def read_in_albums()
    puts 'Please Enter File Name: '
    choice = gets.chomp
    if (choice == 'album.txt')
      puts 'Music libary loaded'
      music_file = File.new("album.txt", "r")
      read_string('Press Enter')
    else
      puts 'No Albums Found'
    end
    main
end

def read_track(music_file)
  name = music_file.gets
  file_location = music_file.gets
  track = Track.new(name, file_location)
  return track
end

def read_tracks(music_file)
  count = music_file.gets.to_i()
  tracks = Array.new()
  index = 0
	while (index < count)
  	track = read_track(music_file)
  	tracks << track
	index += 1
	end
	return tracks
end

def print_tracks(tracks)
  count = tracks.length
  index = 0
  while (index < count)
    print_track (tracks[index])
	index += 1
  end
  
end

def print_track(track)
  puts (track.name)
  puts (track.location)
end

def read_album(music_file)
  title = music_file.gets
  artist = music_file.gets
  image = music_file.gets
  genre = music_file.gets.to_i
  tracks = read_tracks(music_file)
  album = Album.new(title, artist, image, genre, tracks)
  return album
end

def read_albums(music_file)
  count = music_file.gets.to_i()
  albums = Array.new()
  index = 0
	while (index < count)
  	album = read_album(music_file)
  	albums << album
	index += 1
	end
	return albums
end

def print_album(album)
	puts album.title.to_s
	puts album.artist.to_s 
	puts('Genre is ' + $genre_names[album.genre])
	print_tracks(album.tracks)
end

def print_track_only(track)
  puts track.name
end

def print_tracks_only(tracks)
  count = tracks.length
  index = 0
  while (index < count)
    print_track_only (tracks[index])
	index += 1
  end
  
end

def print_album_by_id(album)
  print_tracks_only(album.tracks)
end

def print_albums(albums, genre)
  index = 0 
  while index < albums.length
    if albums[index].genre == genre
      puts('Album ID: ' + (index + 1).to_s())
      print_album albums[index]
    end
    index += 1
  end
end

def search_array(albums, search_item)
  music_file = File.new("album.txt", "r")
  album = read_album(music_file)
  index = 0
	found_index = -1
	while (index < albums.length)
		if (album.genre = search_item)
			found_index = index
		end
		index += 1
	end
	return found_index	
end

def display_by_genre()
  music_file = File.new("album.txt", "r")
  puts 'Select Genre'
  puts '1 - Pop'
  puts '2 - Classic'
  puts '3 - Jazz'
  puts '4 - Rock'
  choice = read_integer_in_range('Option: ', 1, 4)
  albums = read_albums(music_file)
  index = search_array(albums, choice)
  if (index.to_i > -1)
    print_albums(albums, choice)
  else
    puts 'No entry'
  end
end

def display_albums()
    music_file = File.new("album.txt", "r")
    puts '1 - Display all'
    puts '2 - Display by Genre'
    choice = read_integer_in_range('Option: ', 1, 2) 
    case choice
    when 1
        albums = read_albums(music_file)
        print 'Number of albums:' + albums.length.to_s
        puts
        index = 0
        count = albums.length
        while (index < count)
          puts 'Album ID: ' + (index + 1).to_s
          print_album albums[index]
        index += 1
        puts
        end
    when 2
        display_by_genre()
    end
end

def play_album()
    puts 'Play Album by ID'
    music_file = File.new("album.txt", "r")
    albums = read_albums(music_file)
    id = read_integer_in_range('Album ID: ', 1, 4)
    puts 'PLaying Track: '
    print_album_by_id(albums[id - 1])
    puts 'From album ' + albums[id - 1].title
    sleep(3)
end

def update_album
  puts 'Update an album info'
  read_integer_in_range('Album ID: ', 1, 4)
  puts '1 - Update Title'
  puts '2 - Update genre'
  choice = read_integer_in_range('Option :', 1, 2)
  case choice
  when 1
    new_id = read_string('New title: ')
    puts 'Album ID: ' + choice.to_s
    puts 'New ID Update: ' + new_id
  when 2
    new_genre = read_string('New genre: ')
    puts 'Album ID: ' + choice.to_s
    puts 'New Genre Updated: ' + new_genre
  end
  read_string('Press Enter to continue')
end

def main()
  finished = false
  begin
    puts 'Main Menu:'
    puts '1 - Read in Albums'
    puts '2 - Display Albums'
    puts '3 - Select an Album to play'
    puts '4 - Update an existing Album'
    puts '5 - Exit'
    choice = read_integer_in_range("Option:", 1, 5)
    case choice
    when 1
        read_in_albums()
    when 2
        display_albums()
    when 3
        play_album()
    when 4
        update_album()
    else
      finished = true
    end
  end until finished
end
main