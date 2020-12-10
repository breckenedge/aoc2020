module Day1
  module_function

  def p1_input
    data.map(&:to_i)
  end

  def p1(input = p1_input, goal = 2020)
    input.each_with_index do |x, i|
      input[i..].each_with_index do |y, j|
        return x * y if x + y == goal
      end
    end
  end

  def p2_input
    p1_input
  end

  def p2(input = p2_input, goal = 2020)
    input.each_with_index do |x, i|
      input[i..].each_with_index do |y, j|
        input[j..].each_with_index do |z, k|
          return x * y * z if x + y + z == goal
        end
      end
    end
  end

  def data
    @data ||= File.readlines('01.input').map(&:strip)
  end

  def main
    puts "part 1: #{p1}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day1.main if __FILE__ == $0
