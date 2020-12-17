module Day17
  module_function

  ADJACENTS = -1.upto(1).flat_map do |x|
    -1.upto(1).flat_map do |y|
      -1.upto(1).map do |z|
        [x, y, z] unless x == 0 && y == 0 && z == 0
      end
    end
  end.compact

  def neighbor_addresses(address)
    ADJACENTS.map do |adj|
      [address[0] + adj[0], address[1] + adj[1], address[2] + adj[2]]
    end
  end

  def p1(grid = p1_input)
    new_grid = grid.clone

    6.times do
      new_grid = p1_step(new_grid)
    end

    new_grid.values.count { |value| value == '#' }
  end

  def p1_step(grid)
    new_grid = Hash.new('.') # { |hash, unknown_key| hash[unknown_key] = '.' }

    grid.each do |address, _value|
      neighbor_addresses(address).each do |naddr|
        value = grid[naddr]
        active_neighbors = neighbor_addresses(naddr).select { |nnaddr| grid[nnaddr] == '#' }

        if value == '#'
          if (active_neighbors.count == 2 || active_neighbors.count == 3)
            new_grid[naddr] = '#'
          else
            new_grid[naddr] = '.'
          end
        elsif value == '.'
          if active_neighbors.count == 3
            new_grid[naddr] = '#'
          else
            new_grid[naddr] = '.'
          end
        end
      end
    end

    new_grid
  end

  def p1_input(data = self.data)
    grid = Hash.new('.')

    data.each_with_index do |row, row_index|
      row.chars.each_with_index do |cell, col_index|
        grid[[row_index, col_index, 0]] = cell
      end
    end

    grid
  end

  def p2(input = p2_input)
  end

  def p2_input
    p1_input
  end

  def e1(input = e1_input)
    p1(input)
  end

  def e1_input
    p1_input(
      <<~EOS.split("\n")
        .#.
        ..#
        ###
      EOS
    )
  end

  def data(filename = '17.input')
    @data ||= File.readlines(filename).map(&:strip)
  end

  def main
    puts "example 1: #{e1}"
    puts "part 1: #{p1}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day17.main if __FILE__ == $0
