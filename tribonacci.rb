module Tribonacci
  module_function

  def call(i)
    seq = [0, 0, 1]

    0.upto(i) do |j|
      seq << seq[-3, 3].sum
    end

    seq
  end
end
