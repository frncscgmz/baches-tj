BachesTj::Application.routes.draw do
   resources :users, only: [:create, :destroy]
   resources :sessions, only: [:new, :create, :destroy]

   root 'static_pages#home'
   match '/signup',  to: 'users#new',        via: 'get'
   match '/signin',  to: 'sessions#new',     via: 'get'
   match '/signout', to: 'sessions#destroy', via: 'delete'

   match '/help',    to: 'static_pages#help',  via: 'get'
   match '/about',   to: 'static_pages#about', via: 'get'

   #get "baches/new"
   #get "users/new"
end
