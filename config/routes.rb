BachesTj::Application.routes.draw do
  resources :authentications
  devise_for :users
   resources :baches,   only: [:index, :create]
   resources :users,    only: [:create, :destroy]
   resources :sessions, only: [:new, :create, :destroy]

   root to: 'baches#index', via: 'get'

   match '/signup',  to: 'users#new',        via: 'get'
   match '/signin',  to: 'sessions#new',     via: 'get'
   match '/signout', to: 'sessions#destroy', via: 'delete'

   match '/help',    to: 'static_pages#help',  via: 'get'
   match '/about',   to: 'static_pages#about', via: 'get'

end
