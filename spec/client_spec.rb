require('rspec')
require('pg')
require('client')
require('spec_helper')

describe(Client) do

  describe('#name') do
    it("tells you the client name") do
      client = Client.new({:name => "Sally", :id => nil})
      expect(client.name()).to(eq("Sally"))
  end
end

  describe('#id') do
    it("sets the ID when you save it") do
      client = Client.new({:name => "Sally", :id => nil})
      client.save()
      expect(client.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#save') do
    it("lets you save clients to the db") do
      client = Client.new({:name => "Sally", :id => nil})
      client.save()
      expect(Client.all()).to(eq([client]))
    end
  end

  describe(".all") do
    it("starts off with no clients") do
      expect(Client.all()).to(eq([]))
    end
  end

  describe("#==") do
    it("is the same client if they have the same name") do
      client1 = Client.new({:name => "Sally", :id => nil})
      client2 = Client.new({:name => "Sally", :id => nil})
      expect(client1).to(eq(client2))
    end
  end

  describe(".find") do
    it("returns a client by its id") do
      test_client = Client.new({:name => "Sally", :id => nil})
      test_client.save()
      test_client2 = Client.new({:name => "Beety", :id => nil})
      test_client2.save()
      expect(Client.find(test_client2.id())).to(eq(test_client2))
    end
  end

  describe('#delete') do
    it("lets you delete a client from the database") do
      client = Client.new({:name => "Donna", :id => nil})
      client.save()
      client2 = Client.new({:name => "Betty", :id => nil})
      client2.save()
      client.delete()
      expect(Client.all()).to(eq([client2]))
    end
  end
end
