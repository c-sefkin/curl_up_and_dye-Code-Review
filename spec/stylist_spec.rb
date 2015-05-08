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

  describe("#==") do
    it("is the same stylist if they have the same name") do
      stylist1 = Stylist.new({:name => "Sally", :id => nil})
      stylist2 = Stylist.new({:name => "Sally", :id => nil})
      expect(stylist1).to(eq(stylist2))
    end
  end

  describe(".find") do
    it("returns a stylist by its id") do
      test_stylist = Stylist.new({:name => "Sally", :id => nil})
      test_stylist.save()
      test_stylist2 = Stylist.new({:name => "Beety", :id => nil})
      test_stylist2.save()
      expect(Stylist.find(test_stylist2.id())).to(eq(test_stylist2))
    end
  end

  describe("#update") do
    it("lets you update the stylists in the database") do
      stylist = Stylist.new({:name => "Sally", :id => nil})
      stylist.save()
      stylist.update({:name => "Donna"})
      expect(stylist.name()).to(eq("Donna"))
    end

    it("lets you add a client to the stylist") do
      client = Client.new({:name => "Don", :id => nil})
      client.save()
      stylist = Stylist.new({:name => "Donna", :id => nil})
      stylist.save()
      stylist.update({:client_ids => [client.id()]})
      expect(stylist.clients()).to(eq([client]))
    end
  end

  describe("#clients") do
    it("returns a list of clients for that stylist") do
      client = Client.new({:name => "Don", :id => nil})
      client.save()
      client2 = Client.new({:name => "Pete", :id => nil})
      client2.save()
      stylist = Stylist.new({:name => "Donna", :id => nil})
      stylist.save()
      stylist.update({:client_ids => [client.id()]})
      stylist.update({:client_ids => [client2.id()]})
      expect(stylist.clients()).to(eq([client, client2]))
    end
end
end
