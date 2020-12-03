require './circular_list'

def p1(input = p1_input)
  x = 0
  y = 0
  trees = 0

  loop do
    break if y > input.length

    if input[y][x] == '#'
      trees += 1
    end

    x = x + 3
    y = y + 1
  end

rescue
  trees
end

def p1_input
  data.map do |row|
    CircularList.new(row.chars)
  end
end

def p2(input = p2_input)
end

def p2_input
  p1_input
end

def e1(input = e1_input)
end

def e1_input
end

def data(filename = '03.input')
  @data ||= File.readlines(filename).map(&:strip)
end

def main
  puts "example 1: #{e1}"
  puts "part 1: #{p1}"
  puts "part 2: #{p2}"
  exit 0
end

main if __FILE__ == $0
