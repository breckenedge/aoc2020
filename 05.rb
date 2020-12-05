def seat_id(addr)
  row_low = 0
  row_high = 127

  addr[:row].each_char do |inst|
    size = row_high - row_low

    if inst == 'F'
      row_high = row_high - (size / 2) - 1
    else
      row_low = row_low + (size / 2) + 1
    end
  end

  col_low = 0
  col_high = 7

  addr[:col].each_char do |inst|
    size = col_high - col_low

    if inst == 'L'
      col_high = col_high - (size / 2) - 1
    else
      col_low = col_low + (size / 2) + 1
    end
  end

  row_low * 8 + col_low
end

def p1(addresses = p1_input)
  addresses.map { |addr| seat_id(addr) }.max
end

def p1_input
  data.map do |address|
    {
      row: address[0,7],
      col: address[7, 3],
    }
  end
end

def p2(addresses = p2_input)
  real_ids = addresses.map { |addr| seat_id(addr) }
  all_ids = Range.new(real_ids.min, real_ids.max)
  (all_ids.to_a - real_ids).first
end

def p2_input
  p1_input
end

def data(filename = '05.input')
  @data ||= File.readlines(filename).map(&:strip)
end

def main
  puts "part 1: #{p1}"
  puts "part 2: #{p2}"
  exit 0
end

main if __FILE__ == $0
