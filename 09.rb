def p1(input = p1_input, preamble = 25)
  input[preamble, input.length].find.with_index(1) do |number, i|
    crange = input[i - 1, preamble]
    perm = crange.permutation(2)
    perm.none? { |p| p.sum == number }
  end
end

def p1_input(data = self.data)
  data.map(&:to_i)
end

def p2(input = p2_input)
end

def p2_input
  p1_input
end

def e1(input = e1_input)
  p1(input, 5)
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
  puts "part 1: #{p1}"
  puts "part 2: #{p2}"
  exit 0
end

main if __FILE__ == $0
