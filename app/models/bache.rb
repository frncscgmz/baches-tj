class Bache < ActiveRecord::Base
   belongs_to :user
   validates :user_id, presence: true
   validates :desc, presence: true, length: { maximum: 140 }
   validates :latitude, presence: true
   validates :longitude, presence: true

   # Manejo de imagenes
   has_attached_file :foto, :styles => { 
      :medium => "500x500>", :thumb => "100x100>" }
      , :default_url => "/images/:style/missing.png"
   validates_attachment_content_type :foto, :content_type => /\Aimage\/.*\Z/
end
