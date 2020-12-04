module HeightValidator
  module_function

  def call(height)
    if height =~ /in\z/
      (59..76).include?(height.to_i)
    elsif height =~ /cm\z/
      (150..193).include?(height.to_i)
    else
      false
    end
  end
end
