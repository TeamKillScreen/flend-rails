Flend::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  resources :items

  root to: 'static_pages#home'

  match '/sign_in',    to: 'users#sign_in'
  match '/sign_out',   to: 'users#sign_out'
  match '/about',      to: 'static_pages#about'
  match '/contact',    to: 'static_pages#contact'

end
