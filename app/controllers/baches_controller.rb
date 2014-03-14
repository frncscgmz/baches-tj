class BachesController < ApplicationController
   before_action :signed_in_user, only: [:create, :destroy]
   #before_action :correct_user,   only: :destroy

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

   def destroy
      @bache.destroy
      redirect_to root_url
   end

   def gmaps4rails_infowindow(bache)
      if current_user
      "<div id=\"content\">#{view_context.link_to \
      view_context.image_tag(bache.foto.url(:thumb)), bache.foto.url(:original)}\
      <div style=\"float: right\">\
      #{bache.desc}<br/>#{bache.location}<br/>Creado por \
      #{bache.user.name}<br/> Modificado en: \
      #{bache.updated_at.strftime("%B %d, %Y")}<br/>\
      #{view_context.link_to "delete", @bache, method: :delete,\
      data: { confirm: "You sure?" }}</div></div>"
      end
   end

   private

   def bache_params
      params.require(:bache).permit(:desc, :latitude, 
                                    :longitude, :foto)
   end

   def correct_user
      @bache = current_user.bache.find_by(id: params[:id])
      redirect_to root_url if @bache.nil?
   end
end
