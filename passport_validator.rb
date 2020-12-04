module PassportValidator
  module_function

  REQUIRED_FIELDS = %w[byr iyr eyr hgt hcl ecl pid].freeze

  def call(passport)
    REQUIRED_FIELDS.all? { |key| passport.key?(key) }
  end
end
