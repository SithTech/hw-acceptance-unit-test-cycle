Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
  # Resource used: https://guides.rubyonrails.org/routing.html#non-resourceful-routes
  match '/movies/:id/searchDirectors', to: 'movies#searchDirectors', as: 'search_directors', via: :get
  
end
