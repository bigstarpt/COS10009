require 'date'
Inches = 39.3701
def main
    puts "What's your name?"
    name = gets.chomp
    puts "Your name is " + name + "!"
    puts "What's your family name?"
    family_name = gets.chomp
    puts "Your family name is " + family_name + "!"
    puts "What year were you born?"
    year_born = gets.to_i
    age = Date.today.year - year_born
    puts "So you are " + age.to_s + "years old"
    puts "Enter your height in metres:"
    height = gets.to_f
    height_inches = height * Inches
    puts "Your height in inches is:"
    puts height_inches
    puts "Finished"
end
main