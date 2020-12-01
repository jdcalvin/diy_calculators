class ShakerCalc

  #  ___ ___________ ___  
	# |   |           |   |
	# |   |___________|   |
	# | s |           |   |
	# | t |  center   |   |
	# | i |  panel    |   |
	# | l |           |   |
	# | e |___________|   |
	# |   |    rail   |   |
	# |___|___________|___|
	#

	SIDE_WIDTH = 2.0
	SIDE_THICKNESS = 0.75

	attr_reader :width_in, :height_in

	def initialize(width_in:, height_in:)
		@width_in = width_in
		@height_in = height_in
	end

	def print
		max_length = calculations.keys.sort_by(&:size).last.size
		calculations.each_pair do |k,v|
			puts "#{k.ljust(max_length)} | #{Fraction.new(v)}"
		end
		nil
	end

	def calculations
		{
			'Total Side Length (Linear In)' => total_side_length_in,
			'Door Sq ft' => door_sq_ft,
			'Stile Length' => stile_in,
			'Rail Length' => rail_in,
			'Mortise Depth' => mortise_depth,
			'Tenon Length' => tenon_depth,
			'Tenon Thickness' => tenon_thickness,
			'Mortise Width' => mortise_width
			
		}
	end

	def total_side_length_in
		(stile_in * 2) + (rail_in * 2)
	end

	def stile_in
		# stile refers to the vertical side
		height_in
	end

	def door_sq_ft
		(width_in / 12.0) * (height_in / 12.0)
	end

	def rail_in
		# rail refers to the horizontal side
		width_in - (SIDE_WIDTH * 2) + (tenon_depth * 2)
	end

	def tenon_thickness
		SIDE_THICKNESS / 3.to_f
	end

	def mortise_width
		tenon_thickness
	end

	def tenon_depth
		# mortise depth - 1/16 to allow for glue
		mortise_depth - 1/16r.to_f
	end

	def mortise_depth
		# 1/2 of side width

		3/8r.to_f
	end

	def center_panel_thickness
		# material should be same as tenon thickness
		# subtract side width - mortise depth from perimeter + 1/16th for glue
		mortise_width - 1/16r.to_f
	end


	def self.cabinet_widths
		{
			top: 				[
				16.5, 16.5, 16.5, 16.5,
				12, 12, 12, 12,
				13.5, 13.5,
				18
			],
			stove: [
				14.5, 14.5,
			],
			bottom: 		[
				16.5, 16.5, 16.5, 16.5,
				18, 18, 18,
				12, 12
			],
			drawer: 		[
				18, 18, 18, 18,
				16.5, 16.5, 16.5, 16.5,
				24
			],
			big_drawer: 	[
				18, 18
			]
		}
	end

	def self.cabinet_heights
		{
			top: 30,
			stove: 11.5,
			bottom: 24,
			drawer: 6, 
			big_drawer: 12
		}
	end

	def self.calc_door_size(type, nominal_width_in)
		nominal_height_in = cabinet_heights[type]
		width_in = nominal_width_in - 0.375
		height_in = nominal_height_in - 0.375
		{width_in: width_in, height_in: height_in}

		# remove 1/8 from nominal in as current doors reflect this
	end

	def self.calc_kitchen
		doors = []
		cabinet_widths.each_pair do |type, widths|
			widths.each do |width_in|
				doors << self.new(**calc_door_size(type, width_in))
			end
		end
		puts "Total Linear Hardwood Inches: #{Fraction.new(doors.map(&:total_side_length_in).sum)}" 
	end
end