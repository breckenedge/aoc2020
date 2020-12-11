module Day11
  module_function

  def p1(input = p1_input)
    grid = detect_no_changes_in_grid(input)
    grid.flatten.count { |pos| pos == '#' }
  end
  
  def detect_no_changes_in_grid(input)
    grid = Marshal.load(Marshal.dump(input))
    step = 0

    loop do
      new_grid = []

      grid.each_index do |y|
        new_grid[y] = []

        grid[y].each_index do |x|
          if grid[y][x] == 'L' && adjacent_occupied(grid, x, y).count == 0
            new_grid[y][x] = '#'
          elsif grid[y][x] == '#' && adjacent_occupied(grid, x, y).count >= 4
            new_grid[y][x] = 'L'
          else
            new_grid[y][x] = grid[y][x]
          end
        end
      end

      return new_grid if grid == new_grid
      grid = new_grid
      step += 1
    end
  end

  def adjacents
    [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],           [0, 1],
      [1, -1],  [1, 0],  [1, 1]
    ]
  end

  def adjacent_occupied(grid, x, y)
    adjacents.select do |a|
      row_index = y + a[0]
      col_index = x + a[1]
      row = grid[y + a[0]]
      col = row && row[col_index]
      row_index >= 0 && row_index < grid.size && row && col_index >= 0 && col_index < row.size && row[col_index] == '#'
    end
  end

  def p1_input(data = self.data)
    data.map(&:chars)
  end

  def p2(input = p2_input)
    grid = detect_no_changes_in_grid_2(input)
    grid.flatten.count { |pos| pos == '#' }
  end

  def p2_input
    p1_input
  end

  def detect_no_changes_in_grid_2(input)
    grid = Marshal.load(Marshal.dump(input))
    step = 0

    loop do
      new_grid = []

      grid.each_index do |y|
        new_grid[y] = []

        grid[y].each_index do |x|
          if grid[y][x] == 'L' && visible_occupied(grid, x, y).count == 0
            new_grid[y][x] = '#'
          elsif grid[y][x] == '#' && visible_occupied(grid, x, y).count >= 5
            new_grid[y][x] = 'L'
          else
            new_grid[y][x] = grid[y][x]
          end
        end
      end

      return new_grid if grid == new_grid
      grid = new_grid
      step += 1
    end
  end

  def slopes
    [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],           [0, 1],
      [1, -1],  [1, 0],  [1, 1]
    ]
  end

  def visible_occupied(grid, x, y)
    slopes.select do |slope|
      visible_occupied_on_slope?(grid, x, y, slope)
    end
  end

  def visible_occupied_on_slope?(grid, x, y, slope)
    visibles_from(grid, x, y, slope).any? { |pos| pos == '#' }
  end

  def visibles_from(grid, col, row, slope)
    row_index = row
    col_index = col
    visibles = []

    loop do
      row_index += slope[0]
      col_index += slope[1]

      if row_index < 0 || row_index > grid.size || col_index < 0 || grid[row_index].nil? || col_index > grid[row_index].size
        break
      end

      pos = grid[row_index][col_index] 

      visibles << pos

      break if ['#', 'L'].include?(pos)
    end

    visibles
  end

  def e1(input = e1_input)
    p1(input)
  end

  def e1_input
    p1_input(
      <<~EOS.split("\n")
        L.LL.LL.LL
        LLLLLLL.LL
        L.L.L..L..
        LLLL.LL.LL
        L.LL.LL.LL
        L.LLLLL.LL
        ..L.L.....
        LLLLLLLLLL
        L.LLLLLL.L
        L.LLLLL.LL
      EOS
    )
  end

  def data(filename = '11.input')
    @data ||= File.readlines(filename).map(&:strip)
  end

  def main
    puts "example 1: #{e1}"
    puts "part 1: #{p1}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day11.main if __FILE__ == $0
