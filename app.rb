require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/client")
require("./lib/stylist")
require("pg")

DB = PG. connect({:dbname => "hair_salon"})

get('/') do
  @clients = Client.all()
  @stylists = Stylist.all()
  erb(:index)
end

get('/clients') do
  @clients = Client.all()
  erb(:clients)
end

post('/clients') do
  name = params.fetch("name")
  client = Client.new({:name => name, :id => nil})
  client.save()
  @clients = Client.all()
  erb(:clients)
end

get('/stylists') do
  @stylists = Stylist.all()
  erb(:stylists)
end

post('/stylists') do
  name = params.fetch("name")
  stylist = Stylist.new({:name => name, :id => nil})
  stylist.save()
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/clients/:id') do
  id = params.fetch("id").to_i()
  @client = Client.find(id)
  @stylists = Stylist.all()
  erb(:client_info)
end

patch('/clients/:id') do
  name = params.fetch("name")
  client_id = params.fetch("id").to_i()
  @client = Client.find(client_id)
  stylist_ids = params.fetch("stylist_ids", [])
  @client.update({:stylist_ids => stylist_ids, :name => name})
  @stylists = Stylist.all()
  erb(:client_info)
end

delete('/clients/:id') do
  client_id = params.fetch("id").to_i()
  client = Client.find(client_id)
  client.delete()
  @clients = Client.all()
  erb(:clients)
end

get('/stylists/:id') do
  id = params.fetch("id").to_i()
  @stylist = Stylist.find(id)
  @clients = Client.all()
  erb(:stylist_info)
end

patch('/stylists/:id') do
  name = params.fetch("name", [])
  stylist_id = params.fetch("id").to_i()
  @stylist = Stylist.find(stylist_id)
  client_ids = params.fetch("client_ids", [])
  @stylist.update({:client_ids => client_ids, :name => name})
  @clients = Client.all()
  erb(:stylist_info)
end


delete('/stylists/:id') do
  stylist_id = params.fetch("id").to_i()
  stylist = Stylist.find(stylist_id)
  stylist.delete()
  @stylists = Stylist.all()
  erb(:stylists)
end
