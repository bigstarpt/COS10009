# Encoding: UTF-8

require 'rubygems'
require 'gosu'

# Create some constants for the screen width and height
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
# The following determines which layers things are placed on on the screen
# background is the lowest layer (drawn over by other layers), user interface objects are highest.

module ZOrder
  BACKGROUND, FOOD, PLAYER, UI = *0..3
end

# Note: There is one class for each record in the Pascal Food Hunter Game

class Smoke
	attr_accessor :pic, :x, :y, :s, :angle

	def initialize (file)
		@pic = Gosu::Image.new(file)
		@x = x
		@y = y
		@s = 1
		@angle = 0
	end
end

class Hunter
  attr_accessor :score, :image, :yuk, :yum, :hunted, :hunted_image, :vel_x, :vel_y, :angle, :x, :y, :score

  def initialize(hunted)
    @image = Gosu::Image.new("media/Hunter.PNG")
    @yuk = Gosu::Sample.new("media/Yuk.wav")
    @yum = Gosu::Sample.new("media/Yum.wav")

    @hunted = hunted  # default
    @hunted_image = Gosu::Image.new("media/SmallIcecream.png")

    @vel_x = @vel_y = 3.0
    @x = @y = @angle = 0.0
    @score = 0
  end
end

def set_hunted(hunter, hunted)
  hunter.hunted = hunted
  case hunted
  when :chips
    hunted_string = "media/" + "SmallChips.png"
  when :icecream
    hunted_string = "media/" + "SmallIcecream.png"
  when :burger
    hunted_string = "media/" + "SmallBurger.png"
  when :pizza
    hunted_string = "media/" + "SmallPizza.png"
  end
  hunter.hunted_image = Gosu::Image.new(hunted_string)
end

def warp(hunter, x, y)
  hunter.x, hunter.y = x, y
end

def move_left hunter
  hunter.x -= hunter.vel_x
  hunter.x %= SCREEN_WIDTH
end

def move_right hunter
  hunter.x += hunter.vel_x
  hunter.x %= SCREEN_WIDTH
end

def move_up hunter
  hunter.y -= hunter.vel_y
  hunter.y %= SCREEN_HEIGHT
end

def move_down hunter
  hunter.y += hunter.vel_y
  hunter.y %= SCREEN_HEIGHT
end

def draw_hunter hunter
  hunter.image.draw_rot(hunter.x, hunter.y, ZOrder::PLAYER, hunter.angle)
  hunter.hunted_image.draw_rot(hunter.x, hunter.y, ZOrder::PLAYER, hunter.angle)
end

def collect_food(all_food, hunter)
  all_food.reject! do |food|
    if Gosu.distance(hunter.x, hunter.y, food.x, food.y) < 80 # an arbitrary distance - could be improved!!!
      if (food.type == hunter.hunted)
        hunter.score += 1
        hunter.yum.play
      else
        hunter.score += -1
        hunter.yuk.play
      end
      true
    else
      false
    end
  end
end


class Food

  attr_accessor :x, :y, :type, :image, :vel_x, :vel_y, :angle, :x, :y, :score

  def initialize(image, type)
    @type = type;
    @image = Gosu::Image.new(image);
    @vel_x = rand(-2 .. 2)  # rand(1.2 .. 2.0)
    @vel_y = rand(-2 .. 2)
    @angle = 0.0

  # replace hard coded values with global constants:

    @x = rand * SCREEN_WIDTH
    @y = rand * SCREEN_HEIGHT
    @score = 0
  end
end

def move food
  food.x += food.vel_x
  food.x %= SCREEN_WIDTH
  food.y += food.vel_y
  food.y %= SCREEN_HEIGHT
end

def change_direction()
	@food_switched.vel_x = rand(-2..2)
	@food_switched.vel_y = rand(-2..2)
	if @food_switched.vel_x == 0 and @food_switched.vel_y == 0
		change_direction()
	end
end

def draw_food food
  food.image.draw_rot(food.x, food.y, ZOrder::FOOD, food.angle)
end

def set_smoke()
		@index += 1
		@visible_time = Time.new() + 1			
		@smoke.s = 1
		@smoke.angle = 0
end

class FoodHunterGame < (Example rescue Gosu::Window)
  def initialize

    # replace hard coded values with global constants:

    super SCREEN_WIDTH, SCREEN_HEIGHT
    self.caption = "Food Hunter Game"

    @background_image = Gosu::Image.new("media/space.png", :tileable => true)

    @all_food = Array.new

    # Food is created later in generate-food

    @player = Hunter.new(:icecream)

    warp(@player, SCREEN_WIDTH/2, SCREEN_HEIGHT/2)

    @font = Gosu::Font.new(20)
	@change_number = 5000
	@smoke = Smoke.new("media/smoke.png")
	@index = 1
  end

  def update

    # For key mappings see https://www.libgosu.org/cpp/namespace_gosu.html#enum-members

    if Gosu.button_down? Gosu::KB_LEFT or Gosu.button_down? Gosu::GP_LEFT
      move_left @player
    end
    if Gosu.button_down? Gosu::KB_RIGHT or Gosu.button_down? Gosu::GP_RIGHT
      move_right @player
    end
    if Gosu.button_down? Gosu::KB_UP or Gosu.button_down? Gosu::GP_BUTTON_0
      move_up @player
    end
    if Gosu.button_down? Gosu::KB_DOWN or Gosu.button_down? Gosu::GP_BUTTON_9
      move_down @player
    end

    @all_food.each { |food| move food }

    self.remove_food

    collect_food(@all_food, @player)

    # the following will generate new food randomly as update is called each timestep

   if rand(100) < 2 and @all_food.size < 4
      @all_food.push(generate_food)
   end

   # change the hunted food randomly:
   if rand(400) == 0
     change = rand(4)
     case change
      when 0
        set_hunted(@player, :icecream)
      when 1
        set_hunted(@player, :chips)
      when 2
        set_hunted(@player, :burger)
      when 3
        set_hunted(@player, :pizza)
     end
   end
   

	if @all_food.length > 0
		if (Gosu.milliseconds()/@change_number == @index)
			@food_switched = @all_food[rand(@all_food.length)]
			@smoke_create = true
			@smoke.x = @food_switched.x
			@smoke.y = @food_switched.y
			change_direction()
			set_smoke()
		end
	end
 end

  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    draw_hunter @player
    @all_food.each { |food| draw_food food }
    @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
	draw_smoke()
  end

def draw_smoke()
	if @smoke_create == true && Time.now<@visible_time
		@smoke.pic.draw_rot(@smoke.x, @smoke.y, ZOrder::UI, @smoke.angle, 0.5, 0.5, @smoke.s, @smoke.s)
		@smoke.s -= 0.01
		@smoke.angle += 15
	end
end

  def generate_food
    case rand(4)
    when 0
      Food.new("media/Chips.png", :chips)
    when 1
      Food.new("media/Burger.png", :burger)
    when 2
      Food.new("media/IceCream.png", :icecream)
    when 3
      Food.new("media/Pizza.png", :pizza)
    end
  end

  def remove_food
    @all_food.reject! do |food|
      # Replace the following hard coded values with global constants:
      if food.x > SCREEN_WIDTH || food.y > SCREEN_HEIGHT || food.x < 0 || food.y < 0
        true
      else
        false
      end
    end
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    end
  end
end

FoodHunterGame.new.show if __FILE__ == $0
