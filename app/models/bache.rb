class Bache < ActiveRecord::Base
   belongs_to :user
   validates :user_id, presence: true
   validates :desc, presence: true, length: { maximum: 140 }
   validates :latitude, presence: true
   validates :longitude, presence: true
end
