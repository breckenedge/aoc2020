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

  # Rightward rotation: (x, y) => (y, -x)

  # Leftward rotation: (x, y) => (-y, x)

  def p2(input = p2_input)
    ferry = { 'row' => 0, 'col' => 0 }
    waypoint = [-1, -10]

    input.each do |inst|
      case inst['dir']
      when 'N'
        waypoint[0] -= inst['dis'].to_i
      when 'S'
        waypoint[0] += inst['dis'].to_i
      when 'E'
        waypoint[1] -= inst['dis'].to_i
      when 'W'
        waypoint[1] += inst['dis'].to_i
      when 'L', 'R'
        offset = inst['dis'].to_i / 90
        dir = inst['dir']

        offset.times do
          row = waypoint[0]
          col = waypoint[1]

          if dir == 'R'
            col *= -1
          else
            row *= -1
          end

          waypoint[0] = col
          waypoint[1] = row
        end
      when 'F'
        ferry['row'] += waypoint[0] * inst['dis'].to_i
        ferry['col'] += waypoint[1] * inst['dis'].to_i
      end
    end

    ferry['row'].abs + ferry['col'].abs
  end

  def p2_input
    p1_input
  end

  def e2(input = e2_input)
    p2(p1_input(input))
  end

  def e2_input
    <<~EOS.split("\n")
      F10
      N3
      F7
      R90
      F11
    EOS
  end

  def data(filename = '12.input')
    @data ||= File.readlines(filename).map(&:strip)
  end

  def main
    puts "part 1: #{p1}"
    puts "example 2: #{e2}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day12.main if __FILE__ == $0