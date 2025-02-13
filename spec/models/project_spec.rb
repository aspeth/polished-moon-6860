require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :manager }
  end

  describe 'relationships' do
    it { should have_many :items }
  end

  it "displays the item's name, cost, and associated projects" do
    fence = Project.create!(name: "fence repair", manager: "Bob the Builder")
    hammer = Item.create!(name: "hammer", cost: 3, project_id: fence.id)
    drill = Item.create!(name: "drill", cost: 5, project_id: fence.id)
    boards = Item.create!(name: "boards", cost: 4, project_id: fence.id)
    
    expect(fence.average_item_price).to eq(4.00)
  end
end