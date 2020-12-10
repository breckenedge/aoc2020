module Day10
  module_function

  def p1(input = p1_input)
    sorted = [0] + input.sort + [input.max + 3]

    jdiffs = sorted.map.with_index do |jolts, i|
      next if i == 0
      jolts - sorted[i - 1]
    end

    jdiffs.count(3) * jdiffs.count(1)
  end

  def p1_input(data = self.data)
    data
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
    %w[
      28
      33
      18
      42
      31
      14
      46
      20
      48
      47
      24
      23
      49
      45
      19
      38
      39
      11
      1
      32
      25
      35
      8
      17
      7
      9
      4
      2
      34
      10
      3
    ].map(&:to_i)
  end

  def data(filename = '10.input')
    @data ||= File.readlines(filename).map(&:strip).map(&:to_i)
  end

  def main
    puts "example 1: #{e1}"
    puts "part 1: #{p1}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day10.main if __FILE__ == $0
