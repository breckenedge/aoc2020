module Day2
  module_function

  def p1(input = p1_input)
    input.count do |policy, password|
      char_counts = Hash.new { |h, k| h[k] = 0 }

      password.each_char.with_object(char_counts) do |char, h|
        h[char] += 1
      end

      range, letter = policy.split(' ')

      letter.gsub!(':', '')
      low, high = range.split('-').map(&:to_i)

      (low..high).include?(char_counts[letter])
    end
  end

  def p1_input
    data.map do |row|
      row.split(': ')
    end
  end

  def p2(input = p2_input)
    input.count do |policy, password|
      range, letter = policy.split(' ')

      letter.gsub!(':', '')
      low, high = range.split('-').map(&:to_i)

      (password[low - 1] == letter) ^ (password[high - 1] == letter)
    end
  end

  def p2_input
    p1_input
  end

  def data(filename = '02.input')
    @data ||= File.readlines(filename).map(&:strip)
  end

  def main
    puts "part 1: #{p1}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day2.main if __FILE__ == $0
