require './zero_hash'

module Day14
  module_function

  def p1(input = p1_input)
    memory = ZeroHash.new

    input[1..].each do |group|
      mask = group[0].chars

      group[1..].each do |line|
        _, addr, val = /mem.(\d+). = (\d+)/.match(line).to_a

        bits = val.to_i.to_s(2).rjust(36, '0').chars

        new_bits = []

        mask.each_index do |i|
          if mask[i] == 'X'
            new_bits[i] = bits[i]
          else
            new_bits[i] = mask[i]
          end
        end

        memory[addr] = new_bits.join.to_i(2)
      end
    end

    memory.values.sum
  end

  def p1_input(data = self.data)
    data.split("mask = ").map { |g| g.split("\n") }
  end

  def p2(input = p2_input)
  end

  def p2_input
    p1_input
  end

  def e1(input = e1_input)
    p1(p1_input(input))
  end

  def e1_input
    <<~EOS
      mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
      mem[8] = 11
      mem[7] = 101
      mem[8] = 0
    EOS
  end

  def data(filename = '14.input')
    @data ||= File.read(filename)
  end

  def main
    puts "example 1: #{e1}"
    puts "part 1: #{p1}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day14.main if __FILE__ == $0

# > 7744672218184