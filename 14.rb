require './zero_hash'

module Day14
  module_function

  def p1(input = p1_input)
    memory = ZeroHash.new

    input.each do |group|
      mask = group[0].chars

      group[1..].each do |line|
        _, addr, val = /mem.(\d+). = (\d+)/.match(line).to_a

        memory[addr] = get_value(val, mask)
      end
    end

    memory.values.sum
  end

  def get_value(val, mask)
    bits = val.to_i.to_s(2).chars

    new_bits = []

    mask.each_index do |i|
      if mask[i] == 'X'
        new_bits[i] = bits[i]
      else
        new_bits[i] = mask[i]
      end
    end

    new_bits.join.to_i(2)
  end

  def p1_input(data = self.data)
    data.split("mask = ").map { |g| g.split("\n") }[1..]
  end

  def get_addresses(val, mask)
    bits = val.chars

    new_bits = []

    new_bits = mask.map.with_index do |m, i|
      if m == '0'
        bits[i]
      elsif m == '1'
        '1'
      else # floating
        'X'
      end
    end

    floating_count = new_bits.count('X')
    highest = (2 ** floating_count - 1)
    variants = (0..highest).map { |i| i.to_s(2).rjust(floating_count, '0') }

    variants.map do |variant|
      offset = -1

      num = new_bits.map do |b|
        if b == 'X'
          offset += 1
          variant.chars[offset]
        else
          b
        end
      end

      num.join.to_i(2)
    end
  end

  def p2(input = p2_input)
    memory = ZeroHash.new

    input.each do |group|
      mask = group[0].chars

      group[1..].each do |line|
        _, addr, val = /mem.(\d+). = (\d+)/.match(line).to_a

        get_addresses(addr.to_i.to_s(2).rjust(36, '0'), mask).each do |addr|
          memory[addr] = val.to_i
        end
      end
    end

    memory.values.sum
  end

  def p2_input
    p1_input
  end

  def e1(input = e1_data)
    p1(p1_input(input))
  end

  def e1_data
    <<~EOS
      mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
      mem[8] = 11
      mem[7] = 101
      mem[8] = 0
    EOS
  end

  def e2_data
    <<~EOS
      mask = 000000000000000000000000000000X1001X
      mem[42] = 100
      mask = 00000000000000000000000000000000X0XX
      mem[26] = 1
    EOS
  end

  def data(filename = '14.input')
    @data ||= File.read(filename)
  end

  def main
    puts "example 1: #{e1}"
    puts "part 1: #{p1}"
    puts "example 2: #{p2(p1_input(e2_data))}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day14.main if __FILE__ == $0

# < 53907527330408307088
# < 1684775030983568
# < 1383418609923530
# != 4559859020051
