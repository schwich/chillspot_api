class Event < ActiveRecord::Base
  has_many :relationships, dependent: :destroy
  has_many :users, :through => :relationships

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude

  after_validation :geocode, :reverse_geocode

end
