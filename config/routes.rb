Rails.application.routes.draw do
  root to: 'welcome#index'

  get 'signup', 		to:	'users#new', as: :signup
  post 'users',			to:	'users#create'

  get 'login',     	to: 'sessions#new', as: :login
  post 'login',    	to: 'sessions#create'
  get 'logout',	to:	'sessions#destroy', as: :logout

  post '/book_ticket', to: 'event_bookings#book_ticket'
  get 'user_list/:id', to: 'event_bookings#booked_user_list', as: :user_list
  
  resources :event_bookings
  resources :events do
    resources :event_bookings
  end
end
