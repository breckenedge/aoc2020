require 'set'
require './circular_list'
require './game_console'

module Day8
  module_function

  def detect_infinite_loop(boot_code = p1_input)
    gc = GameConsole.new
    gc.game = CircularList.new(boot_code)
    gc.run  { |console| false if console.looped }
    gc.mem[:acc]
  end

  def p1_input(data = self.data)
    data.map do |line|
      ins, arg = line.split(' ')
      [ins, arg.to_i]
    end
  end

  def find_corrupted_instruction(input = p1_input)
    changed_line = 0
    gc = GameConsole.new

    loop do
      boot_code = Marshal.load(Marshal.dump(input))

      if boot_code[changed_line][0] == 'nop'
        boot_code[changed_line][0] = 'jmp'
      elsif boot_code[changed_line][0] == 'jmp'
        boot_code[changed_line][0] = 'nop'
      end

      gc.reboot
      gc.game = boot_code
      gc.run { |console| false if console.looped || console.halted }
      changed_line += 1
      break if gc.halted
    end

    gc.mem[:acc]
  end

  def data(filename = '08.input')
    @data ||= File.readlines(filename).map(&:strip)
  end

  def main
    puts "part 1: #{detect_infinite_loop}"
    puts "part 2: #{find_corrupted_instruction}"
    exit 0
  end
end

Day8.main if __FILE__ == $0
