class Client
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    all_clients =[]
    result = DB.exec("SELECT * FROM clients;")
    result.each() do |client|
      name = client.fetch('name')
      id = client.fetch('id').to_i()
      all_clients.push(Client.new({:name => name, :id => id}))
    end
    all_clients
  end

  define_method(:==) do |other_client|
    self.name().==(other_client.name()).&(self.id().==(other_client.id()))
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylist_clients WHERE client_id = #{self.id()};")
    DB.exec("DELETE FROM clients WHERE id = #{self.id()};")
  end

  define_singleton_method(:find) do |id|
    found_client = []
    Client.all().each() do |client|
      if client.id().==(id)
        found_client = client
      end
    end
    found_client
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE clients SET name = '#{@name}' WHERE id = #{@id};")

    attributes.fetch(:stylist_ids, []).each() do |stylist_id|
      DB.exec("INSERT INTO stylist_clients (stylist_id, client_id) VALUES (#{stylist_id}, #{self.id()};")
    end
  end

end
