Rails.application.routes.draw do
  root   'static_pages#home'
  get    'asthmaticus' => 'static_pages#asthmaticus'
  get    'dka'         => 'static_pages#dka'
  get    'epilepticus' => 'static_pages#epilepticus'
  get    'sepsis'      => 'static_pages#sepsis'
  get    'tbi'         => 'static_pages#tbi'
  get    'signup'      => 'users#new'
  get    'login'       => 'sessions#new'
  post   'login'       => 'sessions#create'
  delete 'logout'      => 'sessions#destroy'
  resources :users
end
