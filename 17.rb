module Day17
  module_function

  def adjacents(dimensions)
    @adjacents ||= {}
    @adjacents[dimensions] ||= [-1, 0, 1].repeated_permutation(dimensions).to_a.reject { |addr| addr.all?(&:zero?) }
  end

  def neighbor_addresses(address)
    @neighbor_addresses ||= {}
    @neighbor_addresses[address] ||= adjacents(address.size).map { |adj| address.size.times.map { |i| address[i] + adj[i] } }
  end

  def p1(grid = p1_input, dimensions = 3, steps = 6)
    new_grid = grid.clone
    steps.times { new_grid = p1_step(new_grid, dimensions) }
    new_grid.values.count { |value| value == '#' }
  end

  def p1_step(grid, dimensions)
    new_grid = {}

    grid.each do |address, _value|
      neighbor_addresses(address).each do |naddr|
        value = grid[naddr]
        active_neighbors = neighbor_addresses(naddr).count { |nnaddr| grid[nnaddr] == '#' }

        if value == '#'
          if active_neighbors == 2 || active_neighbors == 3
            new_grid[naddr] = '#'
          end
        else
          if active_neighbors == 3
            new_grid[naddr] = '#'
          end
        end
      end
    end

    new_grid
  end

  def p1_input(data = self.data, dimensions = 3)
    grid = Hash.new

    data.each_with_index do |row, row_index|
      row.chars.each_with_index do |cell, col_index|
        addr = [row_index, col_index]
        (dimensions - 2).times { addr << 0 }
        grid[addr] = cell
      end
    end

    grid
  end

  def p2(input = p2_input)
    p1(input, 4)
  end

  def p2_input
    p1_input(self.data, 4)
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
