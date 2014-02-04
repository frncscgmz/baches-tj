BachesTj::Application.routes.draw do
   resources :users, only: [:create, :destroy]

   root 'static_pages#home'
   match '/signup',  to: 'users#new',        via: 'get'

   match '/help',  to: 'static_pages#help',  via: 'get'
   match '/about', to: 'static_pages#about', via: 'get'

   #get "baches/new"
   #get "users/new"
end
