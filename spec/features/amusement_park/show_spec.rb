require 'rails_helper'

RSpec.describe 'Amusement park show page' do
  describe 'when I visit an amusement park show page' do
    before :each do
      @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
      @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
      @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
      @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)
      visit "/amusement_parks/#{@six_flags.id}"
    end

    it 'I see the name and price of admission' do
      expect(page).to have_content(@six_flags.name)
      expect(page).to have_content(@six_flags.admission_cost)
    end

    it 'I see the names of all rides at the park in alphabetical order' do
      expect(all('.ride-name')[0].text).to eq(@ferris.name)
      expect(all('.ride-name')[1].text).to eq(@hurler.name)
      expect(all('.ride-name')[2].text).to eq(@scrambler.name)
    end

    it "I see the average thrill rating of this park's rides" do
      expect(page).to have_content('Average Thrill Rating of Rides: 6.0/10')
    end
  end
end