Rails.application.routes.draw do
  devise_for :users
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
  get 'history' => 'pages#history'
  get 'status.svg' => 'pages#current_status_dot', as: 'status_dot'
end
