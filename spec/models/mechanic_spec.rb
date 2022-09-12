require 'rails_helper'

RSpec.describe Mechanic, type: :model do
  describe 'relationships' do
    it { should have_many :ride_mechanics }
    it { should have_many(:rides).through(:ride_mechanics) }
  end

  it 'can order a mechanic rides by thrill rating' do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @mechanic = Mechanic.create!(name: 'Roosevelt Jones', years_experience: 5)
    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)
    @mechanic.rides << @hurler
    @mechanic.rides << @scrambler
    @mechanic.rides << @ferris

    expect(@mechanic.ordered_rides).to eq([@hurler, @ferris, @scrambler]).or eq([@ferris, @hurler, @scrambler])
  end
end