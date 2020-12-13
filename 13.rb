module Day13
  module_function

  def p1(input = p1_input)
    earliest_departure = input[0].to_i
    bus_ids = input[1].split(',').reject { |id| id == 'x' }.map(&:to_i)

    t = earliest_departure
    target_bus_id = nil

    loop do
      bus_ids.each do |bus_id|
        if t % bus_id == 0
          target_bus_id = bus_id
        end
      end

      break if target_bus_id

      t += 1
    end

    target_bus_id * (t - earliest_departure)
  end

  def p1_input(data = self.data)
    data
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

  def data(filename = '13.input')
    @data ||= File.readlines(filename).map(&:strip)
  end

  def main
    puts "example 1: #{e1}"
    puts "part 1: #{p1}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day13.main if __FILE__ == $0
