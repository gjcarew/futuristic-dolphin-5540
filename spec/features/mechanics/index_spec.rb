require 'rails_helper'

RSpec.describe 'Mechanics index' do
  describe 'when I visit a mechanics index page' do
    before :each do
      @mechanic_1 = Mechanic.create!(name: 'Chris', years_experience: 1)
      @mechanic_2 = Mechanic.create!(name: 'Janet', years_experience: 2)
      @mechanic_3 = Mechanic.create!(name: 'Jackson', years_experience: 3)
      @mechanic_4 = Mechanic.create!(name: 'Franklin', years_experience: 4)
      @mechanic_5 = Mechanic.create!(name: 'Roosevelt', years_experience: 5)

      visit '/mechanics'

    end
    it "I see a header saying 'All Mechanics'" do
      expect(all('#header').first.text).to eq('All Mechanics')
    end

    it 'I see a list of all mechanic names and years of experience' do
      expect(page).to have_content(@mechanic_1.name)
      expect(page).to have_content(@mechanic_1.years_experience)
      expect(page).to have_content(@mechanic_2.name)
      expect(page).to have_content(@mechanic_2.years_experience)
      expect(page).to have_content(@mechanic_3.name)
      expect(page).to have_content(@mechanic_3.years_experience)
      expect(page).to have_content(@mechanic_4.name)
      expect(page).to have_content(@mechanic_4.years_experience)
      expect(page).to have_content(@mechanic_5.name)
      expect(page).to have_content(@mechanic_5.years_experience)
    end

    it 'I see average years of experience across all mechanics' do
      average_exp = ((1 + 2 + 3 + 4 + 5).to_f / 5).round(1)
      expect(page).to have_content("Average years of experience: #{average_exp}")
    end
  end
end