class BachesController < ApplicationController

   def index
      @baches = Bache.all
      @hash   = Gmaps4rails.build_markers(@baches) do |bache, marker|
         marker.lat bache.latitude
         marker.lng bache.longitude
         marker.infowindow bache.desc
      end
   end

   def create
      @bache = current_user.baches.build(bache_params)
      if @bache.save
         flash[:success] = "Bache creado."
         redirect_to root_url
      else
         flash.now[:error] = "Error en creacion de bache."
      end
   end

   private

   def bache_params
      params.require(:bache).permit(:desc, :latitude, 
                                    :longitude)
   end
end
