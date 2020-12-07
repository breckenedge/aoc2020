# A +Hash+ where unset keys automatically get a value of +0+.
class ZeroHash
  def initialize
    @hash = Hash.new { |h, k| h[k] = 0 }
  end

  def method_missing(name, *args, &block)
    @hash.send(name, *args, &block)
  end
end
