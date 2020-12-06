# Group lines separated by newlines
module LinesGrouper
  module_function

  def call(inputs)
    collection = []
    current = []

    data.each do |row|
      if row == ""
        collection << current
        current = []
      else
        current << row
      end
    end

    collection << current

    collection
  end
end
