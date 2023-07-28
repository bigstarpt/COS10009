require './input_functions'

# write code that reads in a user's name from the terminal.  
# (use the functions from input_functions.rb) If the name matches
# your name or your tutor's name, then print out "<Name> is an awesome name!"
# Otherwise print out a message that says "<Name> is a silly name"

#def print_silly_name(name)
#  puts name + " is a " + "silly " + "name!"
#end

def main
  name = read_string("What is your name?")
  if name == "Ted" or name == "Matt"
    puts name + " is an awesome name!"
  else
    puts name + " is a silly name"
  end
end

main

