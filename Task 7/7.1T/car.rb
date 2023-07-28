require './input_functions'

# Complete the code below
# Use input_functions to read the data from the user

class Car
    attr_accessor :id, :manufacturer, :model, :kilometres
    def initialize (id, manufacturer, model, kilometres)
        @id = id
        @manufacturer = manufacturer
        @model = model
        @kilometres = kilometres
    end
end

def read_car()
    id = read_integer('Enter car id:')
    manufacturer = read_string('Enter manufacturer:')
    model = read_string('Enter model:')
    kilometres = read_string('Enter kilometres:')
    car = Car.new(id, manufacturer, model, kilometres)
    return car
end

def print_car(car)
    puts('Id: ' + car.id.to_s)
    puts('Manufacturer: ' + car.manufacturer)
    puts('Model: ' + car.model)
    puts('Kilometres: ' + car.kilometres.to_s)
end

def read_cars()
    cars = Array.new()
    count = read_integer_in_range('How many cars are you entering:', 1, 3)
    i = 0
    while (i < count)
        car = read_car()
        cars << car
        i += 1
    end
    return cars
end 

def print_cars(cars)
    index = 0
        while (index < cars.length)
            print_car(cars[index])
            index += 1
        end
    end

def main()
    cars = read_cars()
    print_cars(cars)
end

main()
