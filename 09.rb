module Day9
  module_function

  def find_target(input = p1_input, preamble = 25)
    input[preamble, input.length].find.with_index(1) do |number, i|
      crange = input[i - 1, preamble]
      perm = crange.permutation(2)
      perm.none? { |p| p.sum == number }
    end
  end

  def find_weakness(input = p2_input, preamble = 25)
    target = find_target(input, preamble)
    s = 0
    l = 2

    loop do
      curr = input[s, l]
      sum = curr.sum

      if sum == target
        return curr.minmax.sum
      elsif sum > target
        s += 1
        l = 2
      else
        l += 1
      end
    end
  end

  def p1_input(data = self.data)
    data.map(&:to_i)
  end

  def p2_input
    p1_input
  end

  def e1(input = e1_input)
    find_target(input, 5)
  end

  def e1_input
    <<~EOS.split.map(&:to_i)
      35
      20
      15
      25
      47
      40
      62
      55
      65
      95
      102
      117
      150
      182
      127
      219
      299
      277
      309
      576
    EOS
  end

  def data(filename = '09.input')
    @data ||= File.readlines(filename).map(&:strip)
  end

  def main
    puts "example 1: #{e1}"
    puts "part 1: #{find_target}"
    puts "part 2: #{find_weakness}"
    exit 0
  end
end

Day9.main if __FILE__ == $0
