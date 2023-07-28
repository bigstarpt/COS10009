require './input_functions'

module Genre
POP, CLASSIC, JAZZ, ROCK = *1..4
end

$genre_names = ['Pop', 'Classic', 'Jazz', 'Rock']

class Album
   attr_accessor :title, :artist, :genre, :tracks
   def initialize (title, artist, genre, tracks)
       @title = title
       @artist = artist
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

# Reads in and returns a single track from the given file

def read_track music_file
   # fill in the missing code
   name = music_file.gets()
   location = music_file.gets()
   track = Track.new(name, location)
   return track
end

# Returns an array of tracks read from the given file

def read_tracks music_file
   count = music_file.gets().to_i
   tracks = Array.new
   track = File.open('album.txt')
   i = 0
   while i < count
   track = read_track(music_file)
      tracks << track
      i += 1
   end
   return tracks
end

# Takes an array of tracks and prints them to the terminal

def print_tracks tracks
   index = 0
   while index < tracks.length
      print_track(tracks[index])
   index += 1
   end
end

# Reads in and returns a single album from the given file, with all its tracks

def read_album music_file

# read in all the Album's fields/attributes including all the tracks
   # complete the missing code
	artist = music_file.gets.chomp
	title = music_file.gets.chomp
	genre = music_file.gets.chomp.to_i

	album = Album.new(artist, title, genre, read_tracks(music_file))
end


# Takes a single album and prints it to the terminal along with all its tracks
def print_album album
   print_tracks(album.tracks)
end

# Takes a single track and prints it to the terminal
def print_track track
   puts(track.name)
   puts(track.location)
end

# Reads in an album from a file and then print the album to the terminal


# search for track by name.
# Returns the index of the track or -1 if not found
def search_for_track_name(tracks, search_string)
   found_index = -1
   i = 0
      while (i < tracks.length)
            if (tracks[i].name.chomp == search_string.chomp)
               found_index = i
            end
            i += 1
         end
      found_index
   end


# Reads in an Album from a file and then prints all the album
# to the terminal

def main
music_file = File.new("album.txt", "r")
   album = read_album(music_file)
   music_file.close()
   print_album(album)

   #rest of the code is the same except the following bit

   search_string = read_string("Enter the track name you wish to find: ") #users input a string and is saved
   index = search_for_track_name(album.tracks, search_string) #search track is called and the tracks and the users input is passed
   if index > -1 #if the index which is the value returned from the search is greater than -1
      puts "Found " + album.tracks[index].name + " at " + index.to_s #prints the track name and position
   else
      puts "Entry not Found"
   end

end

main()