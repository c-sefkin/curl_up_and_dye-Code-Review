require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("The salon path", {:type => :feature}) do

  it("visits the clients page") do
    visit('/')
    click_link('Add a new client')
    expect(page).to have_content("Client Portal")
  end

  it("adds a new client") do
    visit('/clients')
    fill_in("name", :with => "John")
    click_button('Add client')
    expect(page).to have_content("John")
  end

  it("adds a new stylist") do
    visit('/stylists')
    fill_in('name', :with => "Sally")
    click_button('Add stylist')
    expect(page).to have_content("Sally")
  end

  it("add a client to a stylist") do
    visit('/clients')
    fill_in('name', :with => "Bob")
    click_button('Add client')
    visit('/stylists')
    click_button('Add clients')
    expect(page).to have_content("Bob")
  end

  it("deletes a client") do
    visit('/clients')
    fill_in('name', :with => "Bob")
    click_button('Add client')
    click_link("Bob")
    click_button("Delete client")
    expect(page).to have_content("Client Portal")
  end

  it("deletes a stylist") do
    visit('/stylists')
    fill_in('name', :with => "Bob")
    click_button('Add stylist')
    click_link("Bob")
    click_button("Remove Stylist")
    expect(page).to have_content("Stylist Portal")
  end

end
