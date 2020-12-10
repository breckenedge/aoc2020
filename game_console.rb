require './zero_hash'
require './circular_list'

class GameConsole
  attr_accessor :mem, :ptr, :ins, :arg, :looped, :halted, :game

  def initialize
    reboot
  end

  def reboot
    @game = []
    @mem = ZeroHash.new
    @ptr = 0
    @ins = nil
    @arg = nil
    @looped = false
    @halted = false
  end

  def run
    visited_lines = Set.new
    size = game.size

    loop do
      @ins, @arg = @game[@ptr]

      case @ins
      when 'nop'
        @ptr += 1
      when 'jmp'
        @ptr += @arg
      when 'acc'
        @mem[:acc] += @arg
        @ptr += 1
      else
        raise "unknown instruction #{@ins} with arg #{@arg}"
      end

      @halted = true if @ptr == size
      @looped = true if visited_lines.include?(@ptr)
      visited_lines.add(@ptr)

      if block_given?
        break if yield(self) == false
      end
    end
  end

  def to_s
    "<GameConsole ptr: #{@ptr} mem: #{@mem} ins: \"#{@ins}\" arg: #{@arg}>"
  end
end
