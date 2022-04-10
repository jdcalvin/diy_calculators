class QuikreteCalc
  # https://www.homedepot.com/p/Quikrete-80-lb-High-Early-Strength-Concrete-Mix-100700/100318486
  # Quikrete's Concrete Mix yield's about .15 cubic feet for every 20 pounds of mix,  
  # 80-pound bag yields .60 cubic feet. 

  attr_reader :total_sq_ft, :linear_in, :cutout_width_in, :cutout_length_in, :depth_in, :bag_lb, :hollowed

  CUBIC_FT_PER_LB = 0.0075
  CUBIC_INCH_PER_FT = 1728
  SQ_IN_PER_FT = (12 * 12)
  BAG_SIZE_LB = 80
  COUNTER_THICKNESS_IN = 1.5
  DEFAULT_COUNTER_DEPTH_IN = 25
  MELAMINE_THICKNESS_IN = 0.75
  REBAR_THICKNESS_IN = 0.375
  REBAR_LB_PER_IN = 0.03133

  # When measuring L Shape countertops,
  # measure linear ft from back end of one side
  # measure linear ft from front end of other side

  def initialize(linear_in:, depth_in: DEFAULT_COUNTER_DEPTH_IN, cutout_width_in:0, cutout_length_in:0, bag_lb: BAG_SIZE_LB, hollowed: false)
    @hollowed = hollowed
    @bag_lb = bag_lb
    @cutout_width_in = cutout_width_in
    @cutout_length_in = cutout_length_in
    @linear_in = linear_in
    @depth_in = depth_in
    
    cutout_sq_inches = cutout_length_in * cutout_width_in
    total_sq_inch = surface_sq_in - cutout_sq_inches
    @total_sq_ft = total_sq_inch / SQ_IN_PER_FT
  end

  def print
    max_length = calc_countertop.keys.sort_by(&:size).last.size
    calc_countertop.each_pair do |k,v|
      puts "#{k.ljust(max_length)} | #{v.ceil(3)}"
    end
    nil
  end

  def calc_countertop
    {
      'Total Square Feet' => total_sq_ft,
      'Total Square Inches' => total_sq_inch,
      'Counter Linear Feet' => (linear_in.to_f / 12),
      'Melamine Linear Feet' => melamine_linear_ft,
      'Concrete Cubic Feet' => countertop_cubic_ft,
      'Total Weight' => countertop_total_material_lb,
      "Total Bags (#{bag_lb} lbs)" => countertop_total_bags,
      'Rebar Feet'  => rebar_ft
    }
  end

  def rebar_perimiter_in
    fb = (linear_in * 2) - 2
    sides = (2 * depth_in) - 2
    fb + sides - (REBAR_THICKNESS_IN * 4)
    # bars should be laid around inside of outer perimeter
    # also laid around outside of inner perimeter (sink)
    # distance from perimeters is 1 inch

    # sink perimeter would just need rebar on sides
    # as front and back will suffice
    
    # spaces greater than a ft should have
    # rebar going front to back
  end

  def surface_sq_in
    linear_in.to_f * depth_in
  end

  def rebar_cutout_in
    return 0 if cutout_length_in == 0 || cutout_width_in == 0

    fb = (cutout_width_in * 2) + 2
    sides = (cutout_length_in * 2) + 2
    fb + sides + (REBAR_THICKNESS_IN * 4)
  end

  def melamine_outer_rim_in
    fb = (linear_in * 2)
    sides = (2 * depth_in)
    fb + sides + (MELAMINE_THICKNESS_IN * 4)
  end

  def melamine_inner_rim_in
    return 0 if cutout_length_in == 0 || cutout_width_in == 0

    fb = cutout_width_in * 2
    sides = cutout_length_in * 2
    fb + sides - (MELAMINE_THICKNESS_IN * 4)
  end

  def rebar_ft
    (rebar_perimiter_in + rebar_cutout_in) / 12
  end

  def melamine_linear_ft
    (melamine_inner_rim_in + melamine_outer_rim_in) / 12
  end

  def countertop_cubic_ft
    total = (total_sq_inch * COUNTER_THICKNESS_IN) / CUBIC_INCH_PER_FT
    if hollowed

      foam_sq_in = (linear_in.to_f - 1) * (depth_in - 1) # foam barrier should sit 1 inch inside surface
      hollowed_depth = COUNTER_THICKNESS_IN - 1.to_f
      if COUNTER_THICKNESS_IN - hollowed_depth < 1
        raise "Counter must be at least 1 inch thick"
      end
      foam_area = (foam_sq_in * hollowed_depth) / CUBIC_INCH_PER_FT
      total - foam_area
    else
      total
    end
  end

  def countertop_total_material_lb
    if hollowed
      rebar = 0
    else
      rebar = (rebar_ft * 12) * REBAR_LB_PER_IN
    end
    (countertop_cubic_ft / CUBIC_FT_PER_LB) + rebar
    
  end

  def countertop_total_bags
    countertop_total_material_lb / bag_lb
  end

  def total_sq_inch
    total_sq_ft * SQ_IN_PER_FT
  end
end