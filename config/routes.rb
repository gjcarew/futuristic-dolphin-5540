Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/mechanics', to: 'mechanics#index'
  get '/mechanics/:id', to: 'mechanics#show'
  patch '/mechanics/:id', to: 'mechanics#update'
end
