require_relative './lines_grouper'

module PassportsParser
  module_function

  def call(input)
    LinesGrouper.(input).map do |group|
      {}.tap do |passport|
        group.each do |line|
          line.split(' ').each do |entry|
            key, value = entry.split(':')
            passport[key] = value
          end
        end
      end
    end
  end
end
