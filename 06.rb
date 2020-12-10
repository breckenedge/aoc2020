require_relative './lines_grouper'

module Day6
  module_function

  def p1(input = p1_input)
    input.sum do |group|
      group.join.each_char.uniq.size
    end
  end

  def p1_input(data = self.data)
    LinesGrouper.(data)
  end

  def p2(input = p2_input)
    input.sum do |group|
      group.join.each_char.tally.select { |c, v| v == group.size }.size
    end
  end

  def p2_input
    p1_input
  end

  def e1(input = e1_input)
    p1_input(e1_input).sum do |group|
      group.join.each_char.uniq.size
    end
  end

  def e1_input
    [
      "abc",
      "",
      "a",
      "b",
      "c",
      "",
      "ab",
      "ac",
      "",
      "a",
      "a",
      "a",
      "a",
      "",
      "b",
    ]
  end

  def data(filename = '06.input')
    @data ||= File.readlines(filename).map(&:strip)
  end

  def main
    puts "example 1: #{e1}"
    puts "part 1: #{p1}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day6.main if __FILE__ == $0
