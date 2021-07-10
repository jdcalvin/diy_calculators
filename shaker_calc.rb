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

  # width_in ###############################
  # -- total door width

  # height_in ##############################
  # -- total door height

  # side_width #############################
  # -- rail/stile workpiece thickness

  # side_thickness #########################
  # -- rail/stile workpiece thickness
  # -- cabinet doors are typically 3/4

  # mortise_depth ##########################
  # -- Joinery rules state this should typically be equal to 1/2 to 2/3 of the workpiece thickness
  # -- In my case, I'm using a special set of mortise/tenon router bits with a defined 7/16th length

  # Reference: https://www.woodmagazine.com/woodworking-how-to/joinery/mortise-tenon-joinery/rule-of-thumb-for-mortise-and-tenon-size

  attr_reader :width_in, 
              :height_in, 
              :side_width, 
              :side_thickness,
              :mortise_depth,
              :label

  def initialize(width_in:, height_in:, side_width: 2.0, side_thickness: 0.75, mortise_depth: 7/16r.to_f, label: nil)
    @width_in = width_in.to_f
    @height_in = height_in.to_f
    @side_width = side_width.to_f
    @side_thickness = side_thickness.to_f
    @mortise_depth = mortise_depth.to_f
    @label = label
  end

  def stile_in
    height_in
  end

  def rail_in
    width_in - (side_width * 2) + (tenon_length * 2)
  end

  def center_panel_dimensions
    [
      rail_in,
      height_in - (side_width * 2) + (tenon_length * 2),
    ]
  end

  def tenon_thickness
    side_thickness / 3.to_f
  end

  def panel_thickness
    tenon_thickness
  end

  def mortise_width
    tenon_thickness
  end

  def tenon_length
    # Typical joinery rules say to leave the tenon 1/16th shorter than mortise depth to allow for glue
    # However in my experience, this requirement is negligible and the finished piece shows a 1/8th variance in width otherwise
    mortise_depth
  end

  def total_side_length_in
    (stile_in * 2) + (rail_in * 2)
  end

  def side_materials
    [
      side_width, stile_in,
      side_width, stile_in,

      side_width, rail_in,
      side_width, rail_in,
    ].each_slice(2).to_a
  end

  def panel_materials
    [
      center_panel_dimensions[0], center_panel_dimensions[1]
    ]
  end

  # presenter methods

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
      'Tenon Length' => tenon_length,
      'Tenon Thickness' => tenon_thickness,
      'Mortise Width' => mortise_width,
      'Side Width' => side_width,
      'Door Thickness' => side_thickness,
      'Center Panel Width' => center_panel_dimensions[0],
      'Center Panel Height' => center_panel_dimensions[1] ,
      'Center Panel Thickness' => panel_thickness
    }
  end  

  def to_h
    {
      total: total_side_length_in,
      stile: stile_in,
      rail: rail_in,
      panel_width: center_panel_dimensions[0],
      panel_height: center_panel_dimensions[1]
    }
  end

  def door_sq_ft
    (width_in / 12.0) * (height_in / 12.0)
  end

  class Collection < Array

    attr_reader :dimensions, :calcs

    def initialize(dimensions)
      super(dimensions.map {|d| calc(d)})
    end

    def <<(d)
      super(calc(d))
    end

    def side_materials(label: false)
      map do |x|
        arr = [x.side_materials]
        arr.push(x.label) if label
        arr
      end
    end

    def panel_materials(label: false)
      map do |x|
        arr = [x.panel_materials]
        arr.push(x.label) if label
        arr
      end
    end

    def total_side_linear_length_in
      sum(&:total_side_length_in)
    end

    private

    def calc(d)
      ShakerCalc.new(height_in: d[0], width_in: d[1], label: d[2])
    end
  end
end
