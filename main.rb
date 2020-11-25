# class for creating instance of Conway's game of life
class Conway
  GRID_HEIGHT = 40
  GRID_WIDTH = 150
  # percentage of cells filled in initial state
  PERCENTAGE_FILLED = 0.1
  def initialize
    @state = create_random_state
  end

  # initialise game state
  def create_random_state
    Array.new(GRID_HEIGHT) do
      Array.new(GRID_WIDTH) { rand < PERCENTAGE_FILLED }
    end
  end

  def draw(state)
    system('clear')

    puts " #{'-' * GRID_WIDTH}"

    state.each do |row|
      print '|'

      row.each do |cell|
        print cell ? '█' : ' '
      end

      puts '|'
    end

    puts " #{'-' * GRID_WIDTH}"
  end

  def count_neighbours(row_index, cell_index)
    neighbours = 0
    ((row_index - 1)..(row_index + 1)).each do |neighbour_row_index|
      ((cell_index - 1)..(cell_index + 1)).each do |neighbour_cell_index|
        # don't need to check self
        if (neighbour_row_index != row_index) || (neighbour_cell_index != cell_index)
          @state[neighbour_row_index][neighbour_cell_index] && neighbours += 1
        end
      end
    end
    neighbours
  end

  # def update_state(old_state)
  def update_state
    new_state = Array.new(GRID_HEIGHT) { Array.new(GRID_WIDTH, false) }

    # loop over each row
    # (ignoring edge cells for simplicity)
    (1...(GRID_HEIGHT - 1)).each do |row_index|
      # loop over each column
      (1...(GRID_WIDTH - 1)).each do |cell_index|
        # for each cell, loop over neighbouring cells
        neighbours = count_neighbours(row_index, cell_index)
        alive = @state[row_index][cell_index] ? [2, 3].include?(neighbours) : neighbours == 3
        new_state[row_index][cell_index] = alive
      end
    end

    new_state
  end

  def animate
    @state = update_state
    draw(@state)
    sleep(0.2)
    animate
  end
end

conway = Conway.new
conway.animate
