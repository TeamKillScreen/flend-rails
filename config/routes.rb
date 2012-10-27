Flend::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  resources :items

  match "/" => "items#index"

end
