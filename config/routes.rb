Rails.application.routes.draw do
  root 'pages#index'
  get 'dashboard/index'
  post 'incidents' => 'dashboard#new_incident'
end
