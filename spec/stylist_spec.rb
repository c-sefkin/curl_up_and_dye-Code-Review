require('rspec')
require('pg')
require('stylist')
require('spec_helper')

describe(Stylist) do

  describe('#name') do
    it("tells you the stylist name") do
      stylist = Stylist.new({:name => "Sally", :id => nil})
      expect(stylist.name()).to(eq("Sally"))
  end
end

  describe('#id') do
    it("sets the ID when you save it") do
      stylist = Stylist.new({:name => "Sally", :id => nil})
      stylist.save()
      expect(stylist.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#save') do
    it("lets you save stylists to the db") do
      stylist = Stylist.new({:name => "Sally", :id => nil})
      stylist.save()
      expect(Stylist.all()).to(eq([stylist]))
    end
  end



  describe(".all") do
    it("starts off with no stylists") do
      expect(Stylist.all()).to(eq([]))
    end
  end
