require './lines_grouper'

module Day16
  module_function

  def p1(input = p1_input)
    input[:nearby].sum do |ticket|
      ticket.sum do |entry|
        if input[:ranges].values.any? { |ranges| ranges.any? { |r| r.include?(entry) } }
          0
        else
          entry
        end
      end
    end
  end

  def p1_input(data = self.data)
    ranges, my_ticket, nearby_tickets = LinesGrouper.(data)

    {
      ranges: ranges.each_with_object({}) do |l, h|
        matches = /(?<name>.+): (?<low>\d+-\d+) or (?<high>\d+-\d+)/.match(l).named_captures

        h[matches['name']] = [
          Range.new(*matches['low'].split('-').map(&:to_i)),
          Range.new(*matches['high'].split('-').map(&:to_i)),
        ]
      end,
      mine: my_ticket[1].split(',').map(&:to_i),
      nearby: nearby_tickets[1..-1].map { |l| l.split(',').map(&:to_i) },
    }
  end

  def p2(input = p2_input)
  end

  def p2_input
    p1_input
  end

  def e1(input = e1_input)
    p1(input)
  end

  def e1_input
    p1_input(<<~EOS.split("\n"))
      class: 1-3 or 5-7
      row: 6-11 or 33-44
      seat: 13-40 or 45-50

      your ticket:
      7,1,14

      nearby tickets:
      7,3,47
      40,4,50
      55,2,20
      38,6,12
    EOS
  end

  def data(filename = '16.input')
    @data ||= File.readlines(filename).map(&:strip)
  end

  def main
    puts "example 1: #{e1}"
    puts "part 1: #{p1}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day16.main if __FILE__ == $0

# !48
