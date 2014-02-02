class Bache < ActiveRecord::Base
   belongs_to :user
   validates :desc, presence: true, length: { maximum: 140 }
   validates :user_id, presence: true
   validates :latitude, presence: true
   validates :longitude, presence: true
end
