require('rspec')
require('pg')
require('stylist')
require('spec_helper')

describe(Stylist) do
  
  describe(".all") do
    it("starts off with no stylists") do
      expect(Stylist.all()).to(eq([]))
    end
  end
