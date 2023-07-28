def write_data_to_file(file_name)
  a_file = File.new(file_name, "w") # open for writing
  if a_file # if nil this test will be false
  a_file.puts('5')
  a_file.puts('Fred')
  a_file.puts('Sam')
  a_file.puts('Jill')
  a_file.puts('Jenny')
  a_file.puts('Zorro')
  a_file.close
  else
    puts "Unable to open file to write!"
  end
end

def read_data_from_file(file_name)
  a_file = File.new(file_name,"r") # open for reading
  if a_file
    count = a_file.gets.to_i
    i = 1
    while (i < count+1)
      puts a_file.gets
      i += 1
    end
  else
    puts "Unable to open file to read!"
  end
end

def main
  write_data_to_file("mydata.txt")
  read_data_from_file("mydata.txt")
end

main