require 'spec_helper'

RSpec.describe ShakerCalc do
  let(:kitchen_cabinets) do
    top_height = 30
    oven_height = 11+1/2r
    bottom_height = 23+3/4r
    top_drawer_height = 6
    
    fridge_height = 15
    [
      # top cabinets
      # doors are numbered left to right
      # values MUST BE height, width, label
      top_height, 17+7/8r, "U1", # u1

      oven_height, 14+7/8r, "U2", #r1
      oven_height, 14+7/8r, "U2", #r2

      top_height, 11+7/8r, "U3", #u2
      top_height, 11+7/8r, "U3", #u3

      top_height, 13+3/8r, "U4",
      top_height, 13+3/8r, "U4",

      top_height, 17+7/8r, "U1",
      top_height, 17+7/8r, "U1",
    
      # bottom cabinets
      bottom_height, 11+7/8r, "L1", # l1 right of stove
      bottom_height, 11+7/8r, "L1", # l2 right of stove
      
      bottom_height, 17+7/8r, "L2", # l3 corner

      bottom_height, 17+7/8r, "L2", # l4 sink
      bottom_height, 17+7/8r, "L2", # l4 sink

      bottom_height, 16+3/8r, "L3", # l5 back corner
      bottom_height, 16+3/8r, "L3", #,  l6 back corner

      # bottom cabinet top drawers
      top_drawer_height, 17+7/8r, "TD1",  # TD1 - left wall next to living room

      top_drawer_height, 11+7/8r, "TD2", # TD2 - right of range
      top_drawer_height, 11+7/8r, "TD2", # TD3 - right of range

      top_drawer_height, 17+7/8r, "TD1", # TD4 - corner
      
      top_drawer_height, 17+7/8r, "TD1", # TD5 - sink
      top_drawer_height, 17+7/8r, "TD1", # TD6 - sink
      
      top_drawer_height, 16+3/8r, "TD3", # TD7 - back corner
      top_drawer_height, 16+3/8r, "TD3",# TD8 - back corner

      # bottom drawers
      11+7/8r, 17+7/8r, "BD1", # bd1 - left wall next to living room
      11+7/8r, 17+7/8r, "BD1", # bd2 - left wall next to living room

      # above fridge cabinets
      fridge_height, 17+7/8r, "F1", # f1
      fridge_height, 17+7/8r, "F1", # f2

      # top pantry
      28+1/2r, 23+7/8r, "TP1", # tp1 
      28+1/2r, 23+7/8r, "TP1", # tp2

      # bottom pantry
      51+1/2r, 23+7/8r, "BP1", # bp1
      51+1/2r, 23+7/8r, "BP1", # bp2

      # pantry cap
      85+1/4r, 24+3/4r, "CP", #CP

      # near living room bottom cap
      33+1/2r, 24+1/2r, "CBLR", #cap-bottom-livingroom

      # near living room top cap
      30, 12+3/8r, "CTLR", #CTLR
      # near sink top cap
      30, 15+3/4r, "CTS",#CTS

      # near bathroom top cap
      30, 15+1/2r, "CTB", #CTB
    ].each_slice(3).to_a
  end

  # describe "::Exporter" do
  #   subject { ShakerCalc::Exporter.new(ShakerCalc::Collection.new(kitchen_cabinets))}

  #   it "#sides" do
  #     v = subject.sides
  #   end

  #   it "#panels" do
  #     v = subject.panels
  #   end
  # end

  describe "::Collection" do
    let(:coll) { ShakerCalc::Collection.new(kitchen_cabinets) }

    it "aggregates dimensions into array of shaker calc instances" do
      expect(coll.count).to eq(kitchen_cabinets.count)
      expect(coll.first.class).to eq ShakerCalc
    end

    it "#side_materials returns array of stile/rail materials dimensions" do
      cuts = [
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 14.75],   [2.0, 14.75]],  "U1"],
        [[[2.0, 11.5],    [2.0, 11.5],    [2.0, 11.75],   [2.0, 11.75]],  "U2"],
        [[[2.0, 11.5],    [2.0, 11.5],    [2.0, 11.75],   [2.0, 11.75]],  "U2"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 8.75],    [2.0, 8.75]],   "U3"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 8.75],    [2.0, 8.75]],   "U3"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 10.25],   [2.0, 10.25]],  "U4"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 10.25],   [2.0, 10.25]],  "U4"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 14.75],   [2.0, 14.75]],  "U1"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 14.75],   [2.0, 14.75]],  "U1"],
        [[[2.0, 23.75],   [2.0, 23.75],   [2.0, 8.75],    [2.0, 8.75]],   "L1"],
        [[[2.0, 23.75],   [2.0, 23.75],   [2.0, 8.75],    [2.0, 8.75]],   "L1"],
        [[[2.0, 23.75],   [2.0, 23.75],   [2.0, 14.75],   [2.0, 14.75]],  "L2"],
        [[[2.0, 23.75],   [2.0, 23.75],   [2.0, 14.75],   [2.0, 14.75]],  "L2"],
        [[[2.0, 23.75],   [2.0, 23.75],   [2.0, 14.75],   [2.0, 14.75]],  "L2"],
        [[[2.0, 23.75],   [2.0, 23.75],   [2.0, 13.25],   [2.0, 13.25]],  "L3"],
        [[[2.0, 23.75],   [2.0, 23.75],   [2.0, 13.25],   [2.0, 13.25]],  "L3"],
        [[[2.0, 6.0],     [2.0, 6.0],     [2.0, 14.75],   [2.0, 14.75]],  "TD1"],
        [[[2.0, 6.0],     [2.0, 6.0],     [2.0, 8.75],    [2.0, 8.75]],   "TD2"],
        [[[2.0, 6.0],     [2.0, 6.0],     [2.0, 8.75],    [2.0, 8.75]],   "TD2"],
        [[[2.0, 6.0],     [2.0, 6.0],     [2.0, 14.75],   [2.0, 14.75]],  "TD1"],
        [[[2.0, 6.0],     [2.0, 6.0],     [2.0, 14.75],   [2.0, 14.75]],  "TD1"],
        [[[2.0, 6.0],     [2.0, 6.0],     [2.0, 14.75],   [2.0, 14.75]],  "TD1"],
        [[[2.0, 6.0],     [2.0, 6.0],     [2.0, 13.25],   [2.0, 13.25]],  "TD3"],
        [[[2.0, 6.0],     [2.0, 6.0],     [2.0, 13.25],   [2.0, 13.25]],  "TD3"],
        [[[2.0, 11.875],  [2.0, 11.875],  [2.0, 14.75],   [2.0, 14.75]],  "BD1"],
        [[[2.0, 11.875],  [2.0, 11.875],  [2.0, 14.75],   [2.0, 14.75]],  "BD1"],
        [[[2.0, 15.0],    [2.0, 15.0],    [2.0, 14.75],   [2.0, 14.75]],  "F1"],
        [[[2.0, 15.0],    [2.0, 15.0],    [2.0, 14.75],   [2.0, 14.75]],  "F1"],
        [[[2.0, 28.5],    [2.0, 28.5],    [2.0, 20.75],   [2.0, 20.75]],  "TP1"],
        [[[2.0, 28.5],    [2.0, 28.5],    [2.0, 20.75],   [2.0, 20.75]],  "TP1"],
        [[[2.0, 51.5],    [2.0, 51.5],    [2.0, 20.75],   [2.0, 20.75]],  "BP1"],
        [[[2.0, 51.5],    [2.0, 51.5],    [2.0, 20.75],   [2.0, 20.75]],  "BP1"],
        [[[2.0, 85.25],   [2.0, 85.25],   [2.0, 21.625],  [2.0, 21.625]], "CP"],
        [[[2.0, 33.5],    [2.0, 33.5],    [2.0, 21.375],  [2.0, 21.375]], "CBLR"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 9.25],    [2.0, 9.25]],   "CTLR"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 12.625],  [2.0, 12.625]], "CTS"],
        [[[2.0, 30.0],    [2.0, 30.0],    [2.0, 12.375],  [2.0, 12.375]], "CTB"]
      ]
      expect(coll.side_materials(label:true)).to eq(cuts)
    end

    it "#panel_materials returns array of center panel dimensions" do
      panels = [
        [[14.625, 26.75], "U1"],
        [[11.625, 8.25], "U2"],
        [[11.625, 8.25], "U2"],
        [[8.625, 26.75], "U3"],
        [[8.625, 26.75], "U3"],
        [[10.125, 26.75], "U4"],
        [[10.125, 26.75], "U4"],
        [[14.625, 26.75], "U1"],
        [[14.625, 26.75], "U1"],
        [[8.625, 20.5], "L1"],
        [[8.625, 20.5], "L1"],
        [[14.625, 20.5], "L2"],
        [[14.625, 20.5], "L2"],
        [[14.625, 20.5], "L2"],
        [[13.125, 20.5], "L3"],
        [[13.125, 20.5], "L3"],
        [[14.625, 2.75], "TD1"],
        [[8.625, 2.75], "TD2"],
        [[8.625, 2.75], "TD2"],
        [[14.625, 2.75], "TD1"],
        [[14.625, 2.75], "TD1"],
        [[14.625, 2.75], "TD1"],
        [[13.125, 2.75], "TD3"],
        [[13.125, 2.75], "TD3"],
        [[14.625, 8.625], "BD1"],
        [[14.625, 8.625], "BD1"],
        [[14.625, 11.75], "F1"],
        [[14.625, 11.75], "F1"],
        [[20.625, 25.25], "TP1"],
        [[20.625, 25.25], "TP1"],
        [[20.625, 48.25], "BP1"],
        [[20.625, 48.25], "BP1"],
        [[21.5, 82.0], "CP"],
        [[21.25, 30.25], "CBLR"],
        [[9.125, 26.75], "CTLR"],
        [[12.5, 26.75], "CTS"],
        [[12.25, 26.75], "CTB"]
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