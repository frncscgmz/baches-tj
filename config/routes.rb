BachesTj::Application.routes.draw do
   devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
      controllers: {omniauth_callbacks: "authentications",
         registrations: "registrations"}
   resources :baches,   only: [:index, :create]
   resources :authentications
   #resources :users,    only: [:create, :destroy]
   #resources :sessions, only: [:new, :create, :destroy]

   match '/auth/:provider/callback' => 'authentications#create', via: 'get'

   root to: 'baches#index', via: 'get'

   #match '/signup',  to: 'users#new',        via: 'get'
   #match '/signin',  to: 'sessions#new',     via: 'get'
   #match '/signout', to: 'sessions#destroy', via: 'delete'

   match '/help',    to: 'static_pages#help',  via: 'get'
   match '/about',   to: 'static_pages#about', via: 'get'

end
