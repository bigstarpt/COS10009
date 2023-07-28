def factorial(n)
    if n == 0
        1
    else
     if n > 0
        n*factorial(n-1)
     elsif
        print("Incorrect argument - need a single argument with a value of 0 or more.")
        end
    end
end

def main
    if ARGV[0].to_i < 1 and ARGV.length < 1
        puts("Incorrect argument - need a single argument with a value of 0 or more.")
    else
        puts factorial(ARGV[0].to_i)
    end
end

main