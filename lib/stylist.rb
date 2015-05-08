class Stylist
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    all_stylists =[]
    result = DB.exec("SELECT * FROM stylists;")
    result.each() do |stylist|
      name = stylist.fetch('name')
      id = stylist.fetch('id').to_i()
      all_stylists.push(Stylist.new({:name => name, :id => id}))
    end
    all_stylists
  end

  define_method(:==) do |other_stylist|
    self.name().==(other_stylist.name()).&(self.id().==(other_stylist.id()))
  end

  define_singleton_method(:find) do |id|
    found_stylist = []
    Stylist.all().each() do |stylist|
      if stylist.id().==(id)
        found_stylist = stylist
      end
    end
    found_stylist
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{@id};")

    attributes.fetch(:client_ids, []).each() do |client_id|
      DB.exec("INSERT INTO stylist_clients (stylist_id, client_id) VALUES (#{self.id()}, #{client_id});")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylist_clients WHERE stylist_id = #{self.id()};")
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
  end

  define_method(:clients) do
    stylist_clients = []
    results = DB.exec("SELECT client_id FROM stylist_clients WHERE stylist_id = #{self.id()};")
    results.each() do |result|
      client_id = result.fetch("client_id").to_i()
      client = DB.exec("SELECT * FROM clients WHERE id = #{client_id};")
      name = client.first().fetch("name")
      stylist_clients.push(Client.new({:name => name, :id => client_id}))
  end
  stylist_clients
end
end
