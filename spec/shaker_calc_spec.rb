require 'spec_helper'

RSpec.describe ShakerCalc do
  let(:kitchen_cabinets) do
    top_height = 30
    oven_height = 11+1/2r
    bottom_height = 23+3/4r
    top_drawer_height = 6
    
    fridge_height = 14+7/8r
    # height, width

    [
      # top cabinets
      top_height, 13+3/8r,
      top_height, 13+3/8r,

      top_height, 11+7/8r,

      top_height, 17+7/8r,
      top_height, 17+7/8r,
      top_height, 17+7/8r,

      # above oven cabinets
      oven_height, 14+7/8r,
      oven_height, 14+7/8r,

      # bottom cabinets
      bottom_height, 11+7/8r,
      bottom_height, 11+7/8r,

      bottom_height, 17+7/8r,
      bottom_height, 17+7/8r,
      bottom_height, 17+7/8r,

      bottom_height, 16+3/8r,
      bottom_height, 16+3/8r,

      # bottom cabinet top drawers
      top_drawer_height, 17+7/8r,
      top_drawer_height, 17+7/8r,
      top_drawer_height, 17+7/8r,
      top_drawer_height, 17+7/8r,

      top_drawer_height, 11+7/8r,
      top_drawer_height, 11+7/8r,

      top_drawer_height, 16+3/8r,
      top_drawer_height, 16+3/8r,

      # bottom drawers
      11+7/8r, 17+7/8r,
      11+7/8r, 17+7/8r,

      # above fridge cabinets

      14+7/8r, 17+7/8r,
      14+7/8r, 17+7/8r,

      # top pantry
      28+1/2r, 23+7/8r, 
      28+1/2r, 23+7/8r, 

      # bottom pantry
      51+1/4r, 23+7/8r, 
      51+1/4r, 23+7/8r, 

      # pantry cap
      24+3/4r, 85+1/4r,

      # bottom cap
      24+3/4r, 24+1/2r,

      # near sink top cap
      30, 15+3/4r,

      # near bathroom bottom cap
      30, 15+1/2r,
    ].each_slice(2).to_a
  end


  describe "::Collection" do
    let(:coll) { ShakerCalc::Collection.new(kitchen_cabinets) }

    it "aggregates dimensions into array of shaker calc instances" do
      expect(coll.count).to eq(kitchen_cabinets.count)
      expect(coll.first.class).to eq ShakerCalc
    end

    it "#side_materials returns array of stile/rail materials dimensions" do
      cuts = [
        [2.0, 30.0], [2.0, 30.0], [2.0, 10.25], [2.0, 10.25], 
        [2.0, 30.0], [2.0, 30.0], [2.0, 10.25], [2.0, 10.25], 
        [2.0, 30.0], [2.0, 30.0], [2.0, 8.75], [2.0, 8.75], 
        [2.0, 30.0], [2.0, 30.0], [2.0, 14.75], [2.0, 14.75], 
        [2.0, 30.0], [2.0, 30.0], [2.0, 14.75], [2.0, 14.75], 
        [2.0, 30.0], [2.0, 30.0], [2.0, 14.75], [2.0, 14.75], 

        [2.0, 11.5], [2.0, 11.5], [2.0, 11.75], [2.0, 11.75], 
        [2.0, 11.5], [2.0, 11.5], [2.0, 11.75], [2.0, 11.75], 

        [2.0, 23.75], [2.0, 23.75], [2.0, 8.75], [2.0, 8.75], 
        [2.0, 23.75], [2.0, 23.75], [2.0, 8.75], [2.0, 8.75], 
        [2.0, 23.75], [2.0, 23.75], [2.0, 14.75], [2.0, 14.75], 
        [2.0, 23.75], [2.0, 23.75], [2.0, 14.75], [2.0, 14.75], 
        [2.0, 23.75], [2.0, 23.75], [2.0, 14.75], [2.0, 14.75], 
        [2.0, 23.75], [2.0, 23.75], [2.0, 13.25], [2.0, 13.25], 
        [2.0, 23.75], [2.0, 23.75], [2.0, 13.25], [2.0, 13.25], 

        [2.0, 6.0], [2.0, 6.0], [2.0, 14.75], [2.0, 14.75], 
        [2.0, 6.0], [2.0, 6.0], [2.0, 14.75], [2.0, 14.75], 
        [2.0, 6.0], [2.0, 6.0], [2.0, 14.75], [2.0, 14.75], 
        [2.0, 6.0], [2.0, 6.0], [2.0, 14.75], [2.0, 14.75], 
        [2.0, 6.0], [2.0, 6.0], [2.0, 8.75], [2.0, 8.75], 
        [2.0, 6.0], [2.0, 6.0], [2.0, 8.75], [2.0, 8.75],
        [2.0, 6.0], [2.0, 6.0], [2.0, 13.25], [2.0, 13.25], 
        [2.0, 6.0], [2.0, 6.0], [2.0, 13.25], [2.0, 13.25], 

        [2.0, 11.875], [2.0, 11.875], [2.0, 14.75], [2.0, 14.75], 
        [2.0, 11.875], [2.0, 11.875], [2.0, 14.75], [2.0, 14.75], 

        [2.0, 14.875], [2.0, 14.875], [2.0, 14.75], [2.0, 14.75], 
        [2.0, 14.875], [2.0, 14.875], [2.0, 14.75], [2.0, 14.75], 

        [2.0, 28.5], [2.0, 28.5], [2.0, 20.75], [2.0, 20.75], 
        [2.0, 28.5], [2.0, 28.5], [2.0, 20.75], [2.0, 20.75], 

        [2.0, 51.25], [2.0, 51.25], [2.0, 20.75], [2.0, 20.75], 
        [2.0, 51.25], [2.0, 51.25], [2.0, 20.75], [2.0, 20.75], 

        [2.0, 24.75], [2.0, 24.75], [2.0, 82.125], [2.0, 82.125],

        [2.0, 24.75], [2.0, 24.75], [2.0, 21.375], [2.0, 21.375], 

        [2.0, 30.0], [2.0, 30.0], [2.0, 12.625], [2.0, 12.625], 

        [2.0, 30.0], [2.0, 30.0], [2.0, 12.375], [2.0, 12.375]
      ]
      expect(coll.side_materials).to eq(cuts)
    end

    it "#panel_materials returns array of center panel dimensions" do
      panels = [
        [10.25, 26.875],
        [10.25, 26.875],
        [8.75, 26.875],
        [14.75, 26.875],
        [14.75, 26.875],
        [14.75, 26.875],
        [11.75, 8.375],
        [11.75, 8.375],
        [8.75, 20.625],
        [8.75, 20.625],
        [14.75, 20.625],
        [14.75, 20.625],
        [14.75, 20.625],
        [13.25, 20.625],
        [13.25, 20.625],
        [14.75, 2.875],
        [14.75, 2.875],
        [14.75, 2.875],
        [14.75, 2.875],
        [8.75, 2.875],
        [8.75, 2.875],
        [13.25, 2.875],
        [13.25, 2.875],
        [14.75, 8.75],
        [14.75, 8.75],
        [14.75, 11.75],
        [14.75, 11.75],
        [20.75, 25.375],
        [20.75, 25.375],
        [20.75, 48.125],
        [20.75, 48.125],
        [82.125, 21.625],
        [21.375, 21.625],
        [12.625, 26.875],
        [12.375, 26.875]
      ]
      expect(coll.panel_materials).to eq panels
    end

    it "side materials should equate panel material count * 4" do
      expect(coll.side_materials.size).to eq 140

      expect(coll.side_materials.size / 4.0).to eq coll.panel_materials.size
    end

    it "#total_side_linear_length_in returns side materials linear length in inches" do
      expect(coll.total_side_linear_length_in).to eq 2597
    end
  end

end