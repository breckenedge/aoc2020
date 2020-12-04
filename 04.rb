REQUIRED_FIELDS = %w[byr iyr eyr hgt hcl ecl pid cid]
EXCEPT = %w[cid]

def passport_valid?(passport)
  (REQUIRED_FIELDS - EXCEPT).all? do |field|
    passport.key?(field)
  end
end

def p1(input = p1_input)
  input.count do |passport|
    passport_valid?(passport)
  end
end

def p1_input
  passports = []
  current_passport = {}

  data.each do |line|
    if line == ""
      passports << current_passport
      current_passport = {}
    end

    entries = line.split(' ')
    entries.each do |entry|
      entry.split(':').each do |key, value|
        current_passport[key] = value
      end
    end
  end

  passports
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

def data(filename = '04.input')
  @data ||= File.readlines(filename).map(&:strip)
end

def main
  puts "example 1: #{e1}"
  puts "part 1: #{p1}"
  puts "part 2: #{p2}"
  exit 0
end

main if __FILE__ == $0
