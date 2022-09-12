require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
  end

  describe 'methods' do
    before :each do
      @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
      @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
      @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
      @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)
    end

    it 'can order rides alphabetically' do
      expect(@six_flags.ordered_rides).to eq([@ferris, @hurler, @scrambler])
    end

    it 'gets average thrill rating for rides at a park' do
      expect(@six_flags.avg_thrill).to eq(6)
    end
  end
end
