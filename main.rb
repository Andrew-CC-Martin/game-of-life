constants = {
  # GRID_HEIGHT: 40,
  GRID_HEIGHT: 10,
  # GRID_WIDTH: 150,
  GRID_WIDTH: 10,
  # percentage of cells filled in initial state
  # PERCENTAGE_FILLED: 0.1
  PERCENTAGE_FILLED: 0.9
}

# initialise game state
def create_random_state(constants)
  Array.new(constants[:GRID_HEIGHT]) do
    Array.new(constants[:GRID_WIDTH]) { rand < constants[:PERCENTAGE_FILLED] }
  end
end

def create_set_state(constants)
  [
    [false, false, true, false, false, false, false, false, false, false],
    [true, false, true, false, false, false, false, false, false, false],
    [false, true, true, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false, false, false]
  ]
end

def draw(state, constants)
  # system('clear')

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

$c = 0

def count_neighbours(old_state:, row_index:, cell_index:)
  neighbours = 0
  if $c < 1
    puts "old state:"
    p old_state
    $c +=1
  end
  ((row_index - 1)..(row_index + 1)).each do |neighbour_row_index|
    ((cell_index - 1)..(cell_index + 1)).each do |neighbour_cell_index|
      # don't need to check self
      if (neighbour_row_index != row_index) && (neighbour_cell_index != cell_index)
        old_state[neighbour_row_index][neighbour_cell_index] && neighbours += 1
      end
    end
  end
  neighbours
end

def update_state(old_state, constants)
  new_state = Array.new(constants[:GRID_HEIGHT]) do
    Array.new(constants[:GRID_WIDTH], false)
  end

  # TODO: handle out of range properly
  # (currently just ignoring last row and column)
  # loop over each row
  (0...(constants[:GRID_HEIGHT] - 1)).each do |row_index|
    # loop over each column
    (0...(constants[:GRID_WIDTH] - 1)).each do |cell_index|
      # for each cell, loop over neighbouring cells
      neighbours = count_neighbours(
        old_state: old_state, row_index: row_index, cell_index: cell_index
      )
      # puts "neighbours for cell (#{row_index}, #{cell_index}): #{neighbours}"

      # new_state[row_index][cell_index] = [2, 3].include?(neighbours)
      # check if cell is currently alive
      # new_state[row_index][cell_index] = if old_state[row_index][cell_index]
      #                                      [2, 3].include?(neighbours)
      #                                    else
      #                                      neighbours == 3
      #                                    end
      # alive = old_state[row_index][cell_index] ? [2, 3].include?(neighbours) : neighbours == 3
      alive = old_state[row_index][cell_index] ? [2, 3].include?(neighbours) : neighbours == 3
      puts "\nfor cell (#{row_index}, #{cell_index})"
      puts "alive before? #{old_state[row_index][cell_index]}"
      puts "neighbours: #{neighbours}"
      puts "alive after? #{alive}"
      new_state[row_index][cell_index] = alive
    end
  end

  new_state
end

def animate(old_state, constants)
  sleep(0.5)
  new_state = update_state(old_state, constants)
  draw(new_state, constants)
  animate(new_state, constants)
end

# start game loop
# initial_state = create_random_state(constants)
initial_state = create_set_state(constants)
draw(initial_state, constants)
new_state = update_state(initial_state, constants)
draw(new_state, constants)
# p initial_state
# animate(initial_state, constants)
# animate(create_random_state(constants), constants)
