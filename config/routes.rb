Rails.application.routes.draw do
  root 'pages#index'
  get 'incidents' => 'pages#index'
  get 'incidents/new' => 'incidents#new'
  get 'incidents/:id' => 'incidents#view'
  get 'incidents/:id/deactivate' => 'incidents#deactivate'
  get 'incidents/:id/edit' => 'incidents#edit'
  get 'incidents/:id/delete' => 'incidents#delete'
  post 'incidents' => 'incidents#create'
  post 'incidents/edit' => 'incidents#edit_incident'
  patch 'incidents/:id/edit' => 'incidents#update'
  delete 'incidents/:id' => 'incidents#delete'
  get 'signout' => 'clearance/sessions#destroy'
  get 'history' => 'pages#history'
  post 'subscribers/new' => 'subscribers#create', as: 'create_subscriber'
  get 'activate/:activation_key' => 'subscribers#activate'

end
