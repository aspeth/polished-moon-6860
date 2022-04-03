require 'rails_helper'

RSpec.describe "item show page" do
  it "displays the item's name, cost, and associated projects" do
    fence = Project.create!(name: "fence repair", manager: "Bob the Builder")
    hammer = Item.create!(name: "hammer", cost: 3, project_id: fence.id)

    visit "/items/#{hammer.id}"
    
    expect(page).to have_content("#{hammer.name}")
    expect(page).to have_content("#{hammer.cost}")
    expect(page).to have_content("#{fence.name}")
  end
  
  it "displays the number of manufacturers for this item" do
    fence = Project.create!(name: "fence repair", manager: "Bob the Builder")
    hammer = Item.create!(name: "hammer", cost: 3, project_id: fence.id)
    drill = Item.create!(name: "drill", cost: 5, project_id: fence.id)
    boards = Item.create!(name: "boards", cost: 4, project_id: fence.id)
    
    ryobi = Manufacturer.create!(name: "Ryobi", location: "Denver")
    board_maker = Manufacturer.create!(name: "Board Maker", location: "The Forest")
    hammer_co = Manufacturer.create!(name: "Hammer Company", location: "Hamburg")
    
    manufacturer_item1 = ManufacturerItem.create!(manufacturer_id: ryobi.id, item_id: hammer.id)
    manufacturer_item2 = ManufacturerItem.create!(manufacturer_id: ryobi.id, item_id: drill.id)
    manufacturer_item3 = ManufacturerItem.create!(manufacturer_id: board_maker.id, item_id: boards.id)
    manufacturer_item4 = ManufacturerItem.create!(manufacturer_id: hammer_co.id, item_id: hammer.id)
    
    visit "/items/#{hammer.id}"
    
    expect(page).to have_content("#{hammer.manufacturer_count}")
  end
  
  it "has a form to add a manufacturer" do
    fence = Project.create!(name: "fence repair", manager: "Bob the Builder")
    hammer = Item.create!(name: "hammer", cost: 3, project_id: fence.id)
    drill = Item.create!(name: "drill", cost: 5, project_id: fence.id)
    boards = Item.create!(name: "boards", cost: 4, project_id: fence.id)
    
    ryobi = Manufacturer.create!(name: "Ryobi", location: "Denver")
    board_maker = Manufacturer.create!(name: "Board Maker", location: "The Forest")
    hammer_co = Manufacturer.create!(name: "Hammer Company", location: "Hamburg")
    
    manufacturer_item1 = ManufacturerItem.create!(manufacturer_id: ryobi.id, item_id: hammer.id)
    manufacturer_item2 = ManufacturerItem.create!(manufacturer_id: ryobi.id, item_id: drill.id)
    manufacturer_item3 = ManufacturerItem.create!(manufacturer_id: board_maker.id, item_id: boards.id)
    
    visit "/items/#{hammer.id}"
    
    expect(page).to have_content("Manufacturer Count: 1")
    
    fill_in 'Manufacturer id', with: "#{hammer_co.id}"
    click_on "Add"
    
    expect(page).to have_content("Manufacturer Count: 2")
  end
end
# As a visitor,
# When I visit a item's show page
# I see a form to add a manufacturer to this project
# When I fill out a field with an existing manufacturer's id
# And hit "Add manufacturer to item"
# I'm taken back to the item's show page
# And I see that the number of manufacturers has increased by 1
# And when I visit the manufacturers index page
# I see that item listed under that manufacturer's name