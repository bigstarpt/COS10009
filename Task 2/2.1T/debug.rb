

require 'date'
# Fix up the following code that it works and produces the expected output
# in the task specification.

# Asks the user to enter their age and returns an integer age
def get_string(prompt)
  puts 
end
def get_age()
    puts "Enter your age in years: "
    age_in_years = gets.to_i()
    return age_in_years
  end
  
  # takes a prompt and displays it to the user then returns the
  # entered string
  def get_string(prompt)
    puts prompt
    name = gets
    return name
  end
  # Calculate the year born based on the parameter age and print that out
  # along with the name of the user
  def print_year_born(name,age_in_years)
    year_born = (Date.today.year - age_in_years).to_s()
    puts name.chomp + " you were born in: " + year_born
  end
  
  def main()
    age_in_years = get_age()
    name = get_string("Enter your name")
    print_year_born(name,age_in_years)
  end
  
  main()