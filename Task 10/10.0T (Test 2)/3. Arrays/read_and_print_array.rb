def read_array()
  value = gets.to_i()
  index = 0
  a = Array.new()
  while (index < value)
    print 'Enter text: '
    lines = gets.chomp().to_s()
    a << lines
    index += 1
  end
  return a
end

def print_array(a)
  index = 0
  puts 'Printing lines:'
  while (index < a.length)
    puts index.to_s + ' ' + a[index]
    index += 1
  end
end

def main()
  print 'How many lines are you entering? '
  a = read_array()
  print_array(a)
end

main()