require 'rails_helper'

RSpec.describe 'Mechanic show page' do
  describe 'When I visit a mechanic show page' do
    before :each do
      @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
      @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
      @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
      @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)
      @mechanic = Mechanic.create!(name: 'Roosevelt Jones', years_experience: 5)
    end

    it 'I see the mechanic name and experience' do
      visit "/mechanics/#{@mechanic.id}"
      expect(page).to have_content(@mechanic.name)
      expect(page).to have_content("Years of experience: #{@mechanic.years_experience}")
    end

    it 'The rides they are working on are listed by thrill rating in descending order' do
      @mechanic.rides << @hurler
      @mechanic.rides << @scrambler
      @mechanic.rides << @ferris
      visit "/mechanics/#{@mechanic.id}"
      expect(all('.ride-name')[0].text).to eq(@hurler.name).or eq(@ferris.name)
      expect(all('.ride-name')[1].text).to eq(@hurler.name).or eq(@ferris.name)
      expect(all('.ride-name')[2].text).to eq(@scrambler.name)
    end

    it 'Add a ride to a mechanic' do
      @mechanic.rides << @hurler
      @mechanic.rides << @scrambler
      visit "/mechanics/#{@mechanic.id}"
      fill_in :ride_ID, with: @ferris.id
      click_on 'Submit'
      expect(current_path).to eq("/mechanics/#{@mechanic.id}")
      expect(page).to have_content(@ferris.name)
      expect(@mechanic.rides).to include(@ferris)
    end
  end
end