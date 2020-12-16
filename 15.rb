module Day15
  module_function

  def p1(input = p1_input, times = 2020)
    spoken = {}
    t = input.length
    last = nil

    input.each_with_index do |v, i|
      spoken[v] ||= []
      spoken[v].push(i)
      last = v
    end

    loaded = false

    loop do
      break if t == times

      nxt = if spoken.key?(last) && spoken[last].length > 1 && loaded
              spoken[last][-1] - spoken[last][-2]
            else
              0
            end

      loaded = true

      spoken[nxt] ||= []
      spoken[nxt].push(t)

      last = nxt
      t += 1
    end

    last
  end

  def p1_input(data = self.data)
    data[0].split(',').map(&:to_i)
  end

  def p2(input = p2_input)
    p1(input, 30_000_000)
  end

  def p2_input
    p1_input
  end

  def e1(input = e1_input)
    p1(e1_input)
  end

  def e1_input
    "0,3,6".split(',').map(&:to_i)
  end

  def data(filename = '15.input')
    @data ||= File.readlines(filename).map(&:strip)
  end

  def main
    puts "example 1: #{e1}"
    puts "part 1: #{p1}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day15.main if __FILE__ == $0
