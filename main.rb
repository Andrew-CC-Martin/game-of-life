# frozen_string_literal: true

constants = {
  GRID_HEIGHT: 40,
  GRID_WIDTH: 150,
  PERCENTAGE_FILLED: 0.1
}

# initialise game state
# around 10% cells filled
def create_state(constants)
  Array.new(constants[:GRID_HEIGHT]) do
    Array.new(constants[:GRID_WIDTH]) { rand < constants[:PERCENTAGE_FILLED] }
  end
end

def draw(state, constants)
  system('clear')

  puts " #{'-' * constants[:GRID_WIDTH]}"

  state.each do |row|
    print '|'

    row.each do |cell|
      print cell ? '█' : ' '
    end

    puts '|'
  end

  puts " #{'-' * constants[:GRID_WIDTH]}"
end

# main game loop
state = create_state(constants)
loop do
  sleep(0.3)
  # todo: calculate new state
  # state = update_state(state)
  draw(state, constants)
end
