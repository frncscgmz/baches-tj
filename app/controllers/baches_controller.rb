class BachesController < ApplicationController
   before_action :signed_in_user, only: [:create, :destroy]
   before_action :correct_user,   only: :destroy

   def index
      @baches = Bache.all
      @hash   = Gmaps4rails.build_markers(@baches) do |bache, marker|
         marker.lat bache.latitude
         marker.lng bache.longitude
         marker.infowindow gmaps4rails_infowindow(bache)
      end
   end

   def create
      @bache = current_user.bache.build(bache_params)
      if @bache.save
         flash[:success] = "Bache creado."
         redirect_to root_url
      else
         flash.now[:error] = "Error en creacion de bache."
      end
   end

   def gmaps4rails_infowindow(bache)
      "#{bache.desc}<br/><img src=\"#{bache.foto.url(:thumb)}\">"
   end

   private

   def bache_params
      params.require(:bache).permit(:desc, :latitude, 
                                    :longitude, :foto)
   end

   def correct_user
      @bache = current_user.baches.find_by(id: params[:id])
      redirect_to root_url if @bache.nil?
   end
end
