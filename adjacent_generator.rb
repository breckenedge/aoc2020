# Given a grid and row column indexes, get all adjacent grid entries
module AdjacentGenerator
  module_function

  ADJACENTS = [
    [-1, -1], [-1,  0], [-1,  1],
    [ 0, -1],           [ 0,  1],
    [ 1, -1], [ 1,  0], [ 1,  1],
  ]

  def call(grid, row_index, col_index)
    rows = grid.size
    cols = grid[0].size

    [].tap do |adjacents|
      ADJACENTS.each do |row_offset, col_offset|
        curr_row = row_index + row_offset
        curr_col = col_index + col_offset

        if curr_row >= 0 && curr_col >= 0 && curr_row < rows && curr_col < cols
          adjacents << grid[curr_row][curr_col]
        end
      end
    end
  end
end

if __FILE__ == $0
  require 'test/unit'

  class AdjacentGeneratorTest < Test::Unit::TestCase
    def setup
      @grid = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
      ]
    end

    def test_adjacent_to_zero
      assert_equal [1, 3, 4], AdjacentGenerator.(@grid, 0, 0)
    end

    def test_adjacent_to_four
      assert_equal [0, 1, 2, 3, 5, 6, 7, 8], AdjacentGenerator.(@grid, 1, 1)
    end

    def test_adjacent_to_seven
      assert_equal [3, 4, 5, 6, 8], AdjacentGenerator.(@grid, 2, 1)
    end
  end
end
