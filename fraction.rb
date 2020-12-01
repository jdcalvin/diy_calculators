class Fraction

	attr_reader :raw, :denominator
	def initialize(val, denominator=DEFAULT_DENOMINATOR)
		@raw = val.to_f
		@denominator = denominator
	end

	# precision is measured to 1/16th
	# value will round to nearest 16th
	DEFAULT_DENOMINATOR = 16

	def inspect
		to_s
	end

	def to_s
		float_to_fraction
	end

	def to_i
		raw.to_i
	end

	def to_f
		raw.to_f
	end

	private

	def float_to_fraction
		remainder = raw - raw.to_i
		return raw.to_i.to_s if remainder == 0
		numerator = remainder / (1.0 / denominator)
		fraction_str = reduce_fraction([numerator.round, denominator])
		display_fraction(raw.to_i, fraction_str)
	end

	def reduce_fraction(fraction)
		numerator = fraction[0]
		denominator = fraction[1]

		if numerator.even?
			reduce_fraction(fraction.map {|x| x / 2})
		else
			"#{numerator}/#{denominator}"
		end	
	end

	def display_fraction(whole_num, fraction_str)
		str = ""
		str += "#{whole_num}-" if whole_num > 0
		str += "(#{fraction_str})"
	end
end