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
      # dors are numbered left to right
      top_height, 17+7/8r, "upper1", # upper1

      oven_height, 14+7/8r, "range1", #range1
      oven_height, 14+7/8r, "range2", #range2

      top_height, 11+7/8r, "upper2", #upper2
      top_height, 11+7/8r, "upper3", #upper3

      top_height, 13+3/8r, "upper4",
      top_height, 13+3/8r, "upper5",

      top_height, 17+7/8r, "upper6",
      top_height, 17+7/8r, "upper7",


      # intentionally missing lazy susan door

      # above oven cabinets
      

      # bottom cabinets
      bottom_height, 11+7/8r, "lower1", # lower1 right of stove
      bottom_height, 11+7/8r, "lower2", # lower2 right of stove
      
      bottom_height, 17+7/8r, "lower3", # lower3 corner

      bottom_height, 17+7/8r, "lower4", # lower4 sink
      bottom_height, 17+7/8r, "lower5", # lower4 sink

      bottom_height, 16+3/8r, "lower6", # lower5 back corner
      bottom_height, 16+3/8r, "lower7", #,  lower6 back corner

      # bottom cabinet top drawers
      top_drawer_height, 17+7/8r, "td1",  # td1 - left wall next to living room

      top_drawer_height, 11+7/8r, "td2", # td2 - right of range
      top_drawer_height, 11+7/8r, "td3", # td3 - right of range

      top_drawer_height, 17+7/8r, "td4", # td4 - corner
      
      top_drawer_height, 17+7/8r, "td5", # td5 - sink
      top_drawer_height, 17+7/8r, "td6", # td6 - sink
      
      top_drawer_height, 16+3/8r, "td7", # td7 - back corner
      top_drawer_height, 16+3/8r, "td8",# td8 - back corner

      # bottom drawers
      11+7/8r, 17+7/8r, "bd1", # bd1 - left wall next to living room
      11+7/8r, 17+7/8r, "bd2", # bd2 - left wall next to living room

      # above fridge cabinets
      15, 17+7/8r, "f1", # f1
      15, 17+7/8r, "f2", # f2

      # top pantry
      28+1/2r, 23+7/8r, "tp1", # tp1 
      28+1/2r, 23+7/8r, "tp2", # tp2

      # bottom pantry
      51+1/2r, 23+7/8r, "bp1", # bp1
      51+1/2r, 23+7/8r, "bp2", # bp2

      # pantry cap
      85+1/4r, 24+3/4r, "cap-pantry", #cap-pantry

      # near living room bottom cap
      33+1/2r, 24+1/2r, "cap-bottom-living-room", #cap-bottom-livingroom

      # near living room top cap
      30, 12+3/8r, "cap-top-lr", #cap-top-lr
      # near sink top cap
      30, 15+3/4r, "cap-top-sink",#cap-top-sink

      # near bathroom top cap
      30, 15+1/2r, "cap-top-bathroom", #cap-top-bathroom
    ].each_slice(3).to_a
  end


  describe "::Collection" do
    let(:coll) { ShakerCalc::Collection.new(kitchen_cabinets) }

    it "aggregates dimensions into array of shaker calc instances" do
      expect(coll.count).to eq(kitchen_cabinets.count)
      expect(coll.first.class).to eq ShakerCalc
    end

    it "#side_materials returns array of stile/rail materials dimensions" do
      cuts = [
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 14.75],   [2.0, 14.75]],  "upper1"],
        [[[2.0, 11.5],    [2.0, 11.5],    [2.0, 11.75],   [2.0, 11.75]],  "range1"],
        [[[2.0, 11.5],    [2.0, 11.5],    [2.0, 11.75],   [2.0, 11.75]],  "range2"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 8.75],    [2.0, 8.75]],   "upper2"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 8.75],    [2.0, 8.75]],   "upper3"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 10.25],   [2.0, 10.25]],  "upper4"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 10.25],   [2.0, 10.25]],  "upper5"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 14.75],   [2.0, 14.75]],  "upper6"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 14.75],   [2.0, 14.75]],  "upper7"],
        [[[2.0, 23.75],   [2.0, 23.75],   [2.0, 8.75],    [2.0, 8.75]],   "lower1"],
        [[[2.0, 23.75],   [2.0, 23.75],   [2.0, 8.75],    [2.0, 8.75]],   "lower2"],
        [[[2.0, 23.75],   [2.0, 23.75],   [2.0, 14.75],   [2.0, 14.75]],  "lower3"],
        [[[2.0, 23.75],   [2.0, 23.75],   [2.0, 14.75],   [2.0, 14.75]],  "lower4"],
        [[[2.0, 23.75],   [2.0, 23.75],   [2.0, 14.75],   [2.0, 14.75]],  "lower5"],
        [[[2.0, 23.75],   [2.0, 23.75],   [2.0, 13.25],   [2.0, 13.25]],  "lower6"],
        [[[2.0, 23.75],   [2.0, 23.75],   [2.0, 13.25],   [2.0, 13.25]],  "lower7"],
        [[[2.0, 6.0],     [2.0, 6.0],     [2.0, 14.75],   [2.0, 14.75]],  "td1"],
        [[[2.0, 6.0],     [2.0, 6.0],     [2.0, 8.75],    [2.0, 8.75]],   "td2"],
        [[[2.0, 6.0],     [2.0, 6.0],     [2.0, 8.75],    [2.0, 8.75]],   "td3"],
        [[[2.0, 6.0],     [2.0, 6.0],     [2.0, 14.75],   [2.0, 14.75]],  "td4"],
        [[[2.0, 6.0],     [2.0, 6.0],     [2.0, 14.75],   [2.0, 14.75]],  "td5"],
        [[[2.0, 6.0],     [2.0, 6.0],     [2.0, 14.75],   [2.0, 14.75]],  "td6"],
        [[[2.0, 6.0],     [2.0, 6.0],     [2.0, 13.25],   [2.0, 13.25]],  "td7"],
        [[[2.0, 6.0],     [2.0, 6.0],     [2.0, 13.25],   [2.0, 13.25]],  "td8"],
        [[[2.0, 11.875],  [2.0, 11.875],  [2.0, 14.75],   [2.0, 14.75]],  "bd1"],
        [[[2.0, 11.875],  [2.0, 11.875],  [2.0, 14.75],   [2.0, 14.75]],  "bd2"],
        [[[2.0, 15.0],    [2.0, 15.0],    [2.0, 14.75],   [2.0, 14.75]],  "f1"],
        [[[2.0, 15.0],    [2.0, 15.0],    [2.0, 14.75],   [2.0, 14.75]],  "f2"],
        [[[2.0, 28.5],    [2.0, 28.5],    [2.0, 20.75],   [2.0, 20.75]],  "tp1"],
        [[[2.0, 28.5],    [2.0, 28.5],    [2.0, 20.75],   [2.0, 20.75]],  "tp2"],
        [[[2.0, 51.5],    [2.0, 51.5],    [2.0, 20.75],   [2.0, 20.75]],  "bp1"],
        [[[2.0, 51.5],    [2.0, 51.5],    [2.0, 20.75],   [2.0, 20.75]],  "bp2"],
        [[[2.0, 85.25],   [2.0, 85.25],   [2.0, 21.625],  [2.0, 21.625]], "cap-pantry"],
        [[[2.0, 33.5],    [2.0, 33.5],    [2.0, 21.375],  [2.0, 21.375]], "cap-bottom-living-room"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 9.25],    [2.0, 9.25]],   "cap-top-lr"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 12.625],  [2.0, 12.625]], "cap-top-sink"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 12.375],  [2.0, 12.375]], "cap-top-bathroom"]
      ]
      expect(coll.side_materials(label:true)).to eq(cuts)
    end

    it "#panel_materials returns array of center panel dimensions" do
      panels = [
        [[14.75, 26.875], "upper1"],
        [[11.75, 8.375], "range1"],
        [[11.75, 8.375], "range2"],
        [[8.75, 26.875], "upper2"],
        [[8.75, 26.875], "upper3"],
        [[10.25, 26.875], "upper4"],
        [[10.25, 26.875], "upper5"],
        [[14.75, 26.875], "upper6"],
        [[14.75, 26.875], "upper7"],
        [[8.75, 20.625], "lower1"],
        [[8.75, 20.625], "lower2"],
        [[14.75, 20.625], "lower3"],
        [[14.75, 20.625], "lower4"],
        [[14.75, 20.625], "lower5"],
        [[13.25, 20.625], "lower6"],
        [[13.25, 20.625], "lower7"],
        [[14.75, 2.875], "td1"],
        [[8.75, 2.875], "td2"],
        [[8.75, 2.875], "td3"],
        [[14.75, 2.875], "td4"],
        [[14.75, 2.875], "td5"],
        [[14.75, 2.875], "td6"],
        [[13.25, 2.875], "td7"],
        [[13.25, 2.875], "td8"],
        [[14.75, 8.75], "bd1"],
        [[14.75, 8.75], "bd2"],
        [[14.75, 11.875], "f1"],
        [[14.75, 11.875], "f2"],
        [[20.75, 25.375], "tp1"],
        [[20.75, 25.375], "tp2"],
        [[20.75, 48.375], "bp1"],
        [[20.75, 48.375], "bp2"],
        [[21.625, 82.125], "cap-pantry"],
        [[21.375, 30.375], "cap-bottom-living-room"],
        [[9.25, 26.875], "cap-top-lr"],
        [[12.625, 26.875], "cap-top-sink"],
        [[12.375, 26.875], "cap-top-bathroom"]
      ]
      expect(coll.panel_materials(label: true)).to eq panels
    end

    it "side materials should equate panel material count * 4" do
      expect(coll.side_materials.flatten(2).size).to eq 148
      expect(coll.side_materials.flatten(2).size / 4.0).to eq coll.panel_materials.size
    end

    it "panels should equal 37 (38 - lazy susan door" do
      expect(coll.size).to eq 37
    end

    it "#total_side_linear_length_in returns side materials linear length in inches" do
      expect(coll.total_side_linear_length_in).to eq 2772
    end
  end

end