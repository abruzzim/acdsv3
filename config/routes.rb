Rails.application.routes.draw do
  get 'guidelines/sepsis'

  root                    'static_pages#home'
  get    'asthmaticus' => 'guidelines#asthmaticus'
  get    'dka'         => 'guidelines#dka'
  get    'epilepticus' => 'guidelines#epilepticus'
  get    'sepsis'      => 'guidelines#sepsis'
  get    'tbi'         => 'guidelines#tbi'
  get    'signup'      => 'users#new'
  get    'login'       => 'sessions#new'
  post   'login'       => 'sessions#create'
  delete 'logout'      => 'sessions#destroy'
  resources :users
end
