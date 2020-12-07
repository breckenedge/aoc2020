require 'set'

BAG = 'shiny gold'

def p1(input = p1_input)
  set = Set.new([BAG])

  loop do
    new_holders = Set.new

    (input.keys - set.to_a).each do |key|
      set.each do |k|
        if input[key].key?(k)
          new_holders << key
        end
      end
    end

    break if new_holders.empty?

    new_holders.each { |k| set.add(k) }
  end

  set.size - 1
end

def p1_input(data = self.data)
  data.each_with_object({}) do |line, hash|
    md = /(?<bag>.+) bags contain (?<contents>.+)/.match(line).named_captures

    hash[md['bag']] = if md['contents'] =~ /no other bags/
                        {}
                      else
                        md['contents'].split(', ').each_with_object({}) do |bd, h|
                          nd = /(?<count>\d+) (?<color>.+) bags?/.match(bd).named_captures
                          h[nd['color']] = nd['count'].to_i
                        end
                      end
  end
end

def p2(input = p2_input)
  totals = Hash.new { |h, k| h[k] = 0 }
  count_bags(input, BAG, totals, 1)
  totals.values.sum
end

def count_bags(input, bag, totals, parent_count)
  if input[bag].any?
    input[bag].each do |bagg, count|
      bag_count = count * parent_count
      totals[bagg] += bag_count
      count_bags(input, bagg, totals, bag_count)
    end
  end
end

def p2_input
  p1_input
end

def e1(input = e1_input)
  set = Set.new([BAG])

  loop do
    new_holders = Set.new

    (input.keys - set.to_a).count do |key|
      set.each do |k|
        if input[key].key?(k)
          new_holders << key
        end
      end
    end

    break if new_holders.empty?

    new_holders.each { |k| set.add(k) }
  end

  set.size - 1
end

def e1_input
  p1_input(example_data)
end

def data(filename = '07.input')
  @data ||= File.readlines(filename).map(&:strip).map { |s| s.gsub(/\.$/, '') }
end

def example_data
  <<~EOS.gsub(/\.$/, '').split("\n")
    light red bags contain 1 bright white bag, 2 muted yellow bags.
    dark orange bags contain 3 bright white bags, 4 muted yellow bags.
    bright white bags contain 1 shiny gold bag.
    muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
    shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
    dark olive bags contain 3 faded blue bags, 4 dotted black bags.
    vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
    faded blue bags contain no other bags.
    dotted black bags contain no other bags.
  EOS
end

def e2(input = e2_input)
  p2(input)
end

def e2_input
  data = <<~EOS.split("\n")
    shiny gold bags contain 2 dark red bags.
    dark red bags contain 2 dark orange bags.
    dark orange bags contain 2 dark yellow bags.
    dark yellow bags contain 2 dark green bags.
    dark green bags contain 2 dark blue bags.
    dark blue bags contain 2 dark violet bags.
    dark violet bags contain no other bags.
  EOS

  p1_input(data)
end

def main
  puts "example 1: #{e1}"
  puts "part 1: #{p1}"
  puts "example 2: #{e2}"
  puts "part 2: #{p2}"
  exit 0
end

main if __FILE__ == $0
