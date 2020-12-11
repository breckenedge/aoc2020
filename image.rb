require 'rmagick'

module Image
  module_function

  def grid_to_image(grid, map = { '#' => 'darkgray', 'L' => 'gray', '.' => 'white' })
    height = grid.size
    width = grid[0].size
    image = Magick::Image.new(width, height)

    grid.each_with_index { |row, y|
      row.each_with_index { |col, x|
        image.pixel_color(x, y, map[col])
      }
    }

    image
  end
end
