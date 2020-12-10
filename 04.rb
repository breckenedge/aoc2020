require './passports_parser'
require './passport_validator'
require './passport_data_validator'

module Day4
  module_function

  def p1(input = p1_input)
    input.count do |passport|
      PassportValidator.(passport)
    end
  end

  def p1_input
    PassportsParser.(data)
  end

  def p2(input = p2_input)
    input.select { |passport| PassportValidator.(passport) }
      .select { | passport| PassportDataValidator.(passport) }
      .count
  end

  def p2_input
    p1_input
  end

  def data(filename = '04.input')
    @data ||= File.readlines(filename).map(&:strip)
  end

  def main
    puts "part 1: #{p1}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day4.main if __FILE__ == $0
