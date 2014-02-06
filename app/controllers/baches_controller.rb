class BachesController < ApplicationController
   def index
      @baches = Bache.all
      @hash   = Gmaps4rails.build_markers(@baches) do |bache, marker|
         marker.lat bache.latitude
         marker.lng bache.longitude
         marker.title bache.desc
      end
   end

  def new
  end
end
