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
    tickets = valid_tickets(input[:nearby], input[:ranges])
    entries = tickets.transpose
    locked_fields = {}

    loop do
      entries.each_with_index do |e, i|
        pfields = possible_fields(e, input[:ranges], locked_fields)

        if pfields.one?
          locked_fields[pfields[0]] = i
        end
      end

      break if locked_fields.keys.length == input[:ranges].keys.length
    end

    departure_fields = locked_fields.keys.select { |k| k =~ /^departure/ }

    departure_fields.inject(1) do |tot, field|
      tot *= input[:mine][locked_fields[field]]
    end
  end

  def possible_fields(entries, ranges, locked_fields)
    (ranges.keys - locked_fields.keys).select do |k|
      entries.all? do |e|
        ranges[k].any? do |r|
          r.include?(e)
        end
      end
    end
  end

  def valid_tickets(tickets, ranges)
    tickets.select do |ticket|
      ticket.all? do |entry|
        ranges.values.any? { |ranges| ranges.any? { |r| r.include?(entry) } }
      end
    end
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

  def e2_input
    p1_input(<<~EOS.split("\n"))
      class: 0-1 or 4-19
      row: 0-5 or 8-19
      seat: 0-13 or 16-19

      your ticket:
      11,12,13

      nearby tickets:
      3,9,18
      15,1,5
      5,14,9
    EOS
  end

  def e2(input = e2_input)
    p2(input)
  end

  def data(filename = '16.input')
    @data ||= File.readlines(filename).map(&:strip)
  end

  def main
    puts "example 1: #{e1}"
    puts "part 1: #{p1}"
    puts "example 2: #{e2}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day16.main if __FILE__ == $0

# !48
