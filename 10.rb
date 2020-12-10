require './tribonacci'

module Day10
  module_function

  def p1(input = p1_input)
    max = input.max + 3
    sorted = [0] + input.sort + [max]

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
    max = input.max + 3
    jolts = [0] + input.sort + [max]
    gap_groups = []
    current_group = []

    jolts.each_with_index do |jolt, i|
      if jolt - jolts[i - 1] == 3
        gap_groups << current_group.dup
        current_group = [jolt]
      else
        current_group << jolt
      end
    end

    gap_groups << current_group

    sum = 1

    max_size = gap_groups.map(&:size).max
    tribonaccis = Tribonacci.(max_size)

    gap_groups.each do |group|
      sum *= tribonaccis[group.length + 1]
    end

    sum
  end

  def p2_input
    p1_input
  end

  def e1(input = e1_input)
    p1(input)
  end

  def e1_input
    %w[
      16
      10
      15
      5
      1
      11
      7
      19
      6
      12
      4
    ].map(&:to_i)
  end

  def e2_input
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
    puts "example 2: #{p2(e2_input)}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day10.main if __FILE__ == $0
