require 'rmagick'

module Image
  module_function

  def grid_to_image(grid, map = { '#' => 'red', 'L' => 'green', '.' => 'black' }, scaling: 4)
    height = grid.size * scaling
    width = grid[0].size * scaling
    image = Magick::Image.new(width, height)

    grid.each_with_index { |row, y|
      row.each_with_index { |col, x|
        (0..(scaling ** 2 - 1)).each_slice(scaling).with_index do |slice, i|
          slice.each_index do |j|
            pix = (x * scaling) + j
            piy = (y * scaling) + i
            image.pixel_color(pix, piy, map[col])
          end
        end
      }
    }

    image
  end
end
