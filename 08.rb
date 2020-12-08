require 'set'
require './circular_list'

def p1(input = p1_input)
  visited_lines = Set.new
  line = 0
  accum = 0

  loop do
    break if visited_lines.include?(line)

    visited_lines.add(line)

    ins, arg = input[line]

    case ins
    when 'nop'
      line += 1
    when 'jmp'
      line += arg
    when 'acc'
      accum += arg
      line += 1
    end
  end

  accum
end

def p1_input(data = self.data)
  CircularList.new(data.map do |line|
    ins, arg = line.split(' ')
    [ins, arg.to_i]
  end)
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
  str = <<~EOS.split("\n")
    nop +0
    acc +1
    jmp +4
    acc +3
    jmp -3
    acc -99
    acc +1
    jmp -4
    acc +6
  EOS

  p1_input(str)
end

def data(filename = '08.input')
  @data ||= File.readlines(filename).map(&:strip)
end

def main
  puts "example 1: #{e1}"
  puts "part 1: #{p1}"
  puts "part 2: #{p2}"
  exit 0
end

main if __FILE__ == $0
