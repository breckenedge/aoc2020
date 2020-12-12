# Given a grid and row column indexes, get all cardinal grid entries
module CardinalGenerator
  Cell = Struct.new(:row, :col, :val) do
    def to_i
      val
    end
  end

  module_function

  CARDINALS = [
              [-1,  0],
    [ 0, -1],           [ 0,  1],
              [ 1,  0],
  ]

  def call(grid, row_index, col_index)
    rows = grid.size
    cols = grid[0].size

    [].tap do |cardinals|
      CARDINALS.each do |row_offset, col_offset|
        curr_row = row_index + row_offset
        curr_col = col_index + col_offset

        if curr_row >= 0 && curr_col >= 0 && curr_row < rows && curr_col < cols
          cardinals << Cell.new(curr_row, curr_col, grid[curr_row][curr_col])
        end
      end
    end
  end
end

if __FILE__ == $0
  require 'test/unit'

  class CardinalGeneratorTest < Test::Unit::TestCase
    def setup
      @grid = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
      ]
    end

    def test_adjacent_to_zero
      assert_equal [1, 3], CardinalGenerator.(@grid, 0, 0).map(&:val)
    end

    def test_adjacent_to_four
      assert_equal [1, 3, 5, 7], CardinalGenerator.(@grid, 1, 1).map(&:val)
    end

    def test_adjacent_to_seven
      assert_equal [4, 6, 8], CardinalGenerator.(@grid, 2, 1).map(&:val)
    end
  end
end
