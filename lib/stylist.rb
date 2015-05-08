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
end
