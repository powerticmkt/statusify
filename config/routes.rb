Rails.application.routes.draw do
  root 'pages#index'
  get 'incidents' => 'pages#index'
  get 'incidents/new' => 'incidents#new'
  post 'incidents' => 'incidents#create'
  get 'incidents/:id' => 'incidents#edit'
  post 'incidents/edit' => 'incidents#edit_incident'
  patch 'incidents/:id' => 'incidents#update'
  delete 'incidents/:id' => 'incidents#delete'
  get 'incidents/delete/:id' => 'incidents#delete'
  get 'signout' =>  'clearance/sessions#destroy'
end
