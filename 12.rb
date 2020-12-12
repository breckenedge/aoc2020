require './circular_list'

module Day12
  module_function

  HEADINGS = CircularList.new(['E', 'N', 'W', 'S'])

  def p1(input = p1_input)
    ferry = { 'row' => 0, 'col' => 0, 'head' => 'E' }

    input.each do |inst|
      case inst['dir']
      when 'N'
        ferry['row'] -= inst['dis'].to_i
      when 'S'
        ferry['row'] += inst['dis'].to_i
      when 'E'
        ferry['col'] += inst['dis'].to_i
      when 'W'
        ferry['col'] -= inst['dis'].to_i
      when 'L', 'R'
        curr_index = HEADINGS.index(ferry['head'])
        offset = inst['dis'].to_i / 90
        ferry['head'] = inst['dir'] == 'L' ? HEADINGS[curr_index + offset] : HEADINGS[curr_index - offset]
      when 'F'
        case ferry['head']
        when 'N'
          ferry['row'] -= inst['dis'].to_i
        when 'S'
          ferry['row'] += inst['dis'].to_i
        when 'E'
          ferry['col'] += inst['dis'].to_i
        when 'W'
          ferry['col'] -= inst['dis'].to_i
        end
      end
    end
    
    ferry['row'].abs + ferry['col'].abs
  end

  def p1_input(data = self.data)
    data.map { |line| /(?<dir>\D+)(?<dis>\d+)/.match(line).named_captures }
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

  def data(filename = '12.input')
    @data ||= File.readlines(filename).map(&:strip)
  end

  def main
    puts "example 1: #{e1}"
    puts "part 1: #{p1}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day12.main if __FILE__ == $0
