require './circular_list'

module Day3
  module_function

  def p1(input = p1_input, slope = [3, 1])
    x = 0
    y = 0
    trees = 0

    loop do
      break if y >= input.length

      if input[y][x] == '#'
        trees += 1
      end

      x = x + slope[0]
      y = y + slope[1]
    end

    trees
  end

  def p1_input
    data.map do |row|
      CircularList.new(row.chars)
    end
  end

  def p2(input = p2_input)
    [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]].map do |slope|
      p1(input, slope)
    end.inject(:*)
  end

  def p2_input
    p1_input
  end

  def data(filename = '03.input')
    @data ||= File.readlines(filename).map(&:strip)
  end

  def main
    puts "part 1: #{p1}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day3.main if __FILE__ == $0
