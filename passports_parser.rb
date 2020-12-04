module PassportsParser
  module_function

  def call(input)
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
end
