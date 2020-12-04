REQUIRED_FIELDS = %w[byr iyr eyr hgt hcl ecl pid cid]
EXCEPT = %w[cid]
EYE_COLORS = %w[amb blu brn gry grn hzl oth]

def passport_valid?(passport)
  (REQUIRED_FIELDS - EXCEPT).all? do |field|
    passport.key?(field)
  end
end

def passport_data_valid?(passport)
  ('1920'..'2002').include?(passport['byr']) &&
    ('2010'..'2020').include?(passport['iyr']) &&
    ('2020'..'2030').include?(passport['eyr']) &&
    height_valid?(passport['hgt']) &&
    /\A\#[0-9a-f]{6}\z/.match?(passport['hcl']) &&
    EYE_COLORS.include?(passport['ecl']) &&
    /\A\d{9}\z/.match?(passport['pid'])
end

def height_valid?(height)
  if height =~ /in\z/
    (59..76).include?(height.to_i)
  elsif height =~ /cm\z/
    (150..193).include?(height.to_i)
  else
    false
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
      key, value = entry.split(':')
      current_passport[key] = value
    end
  end

  passports
end

def p2(input = p2_input)
  input.select { |passport| passport_valid?(passport) }
    .select { |passport| passport_data_valid?(passport) }
    .count
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
