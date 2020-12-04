require_relative './height_validator'

module PassportDataValidator
  EYE_COLORS = %w[amb blu brn gry grn hzl oth]

  module_function

  def call(passport)
    ('1920'..'2002').include?(passport['byr']) &&
      ('2010'..'2020').include?(passport['iyr']) &&
      ('2020'..'2030').include?(passport['eyr']) &&
      HeightValidator.(passport['hgt']) &&
      /\A\#[0-9a-f]{6}\z/.match?(passport['hcl']) &&
      EYE_COLORS.include?(passport['ecl']) &&
      /\A\d{9}\z/.match?(passport['pid'])
  end
end
