class Mechanic < ApplicationRecord
  has_many :ride_mechanics
  has_many :rides, through: :ride_mechanics

  def ordered_rides
    rides.order(thrill_rating: :desc)
  end
end
