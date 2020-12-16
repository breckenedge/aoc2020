module Day15
  module_function

  def p1(input = p1_input)
    spoken = input.clone
    t = 0

    loop do
      last = spoken.last
      slice = spoken[0..(spoken.length - 2)]

      if slice.include?(last)
        index1 = spoken.rindex(last)
        index2 = spoken[0..(index1 - 1)].rindex(last)
        spoken << index1 - index2
      else
        spoken << 0
      end

      break if spoken.length == 2020

      t += 1
    end

    spoken.last
  end

  def p1_input(data = self.data)
    data[0].split(',').map(&:to_i)
  end

  def p2(input = p2_input)
  end

  def p2_input
    p1_input
  end

  def e1(input = e1_input)
    p1(e1_input)
  end

  def e1_input
    "0,3,6".split(',').map(&:to_i)
  end

  def data(filename = '15.input')
    @data ||= File.readlines(filename).map(&:strip)
  end

  def main
    puts "example 1: #{e1}"
    puts "part 1: #{p1}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day15.main if __FILE__ == $0
