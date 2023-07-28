require './input_functions'

# you need to complete the following procedure that prints out 
# "<Name> is a " then print 'silly' (60 times) on one long line
# then print ' name.' \newline
 
def print_silly_name(name)
	i = 0
	puts name + " is a"
	while i < 60
		print("silly ")
		i += 1
	end
	puts "name!"
end

def main
	name = read_string("What is your name?")
	if name.downcase == "ted"
	  puts ("is an awesome name!")
	elsif name.downcase == "matt"
	  puts ("is a awesome name!")
	else
		print_silly_name(name)
  end
end
main()
