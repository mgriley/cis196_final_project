Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # serve the website
  root 'notebook#index'

  # REST API

  get 'api/file_tree', to: 'notebook#file_tree'
  get 'api/note', to: 'notebook#note'

  post 'api/create_note', to: 'notebook#create_note'
  post 'api/move_note', to: 'notebook#move_note'
  post 'api/destroy_note', to: 'notebook#destroy_note'
  post 'api/rename_note', to: 'notebook#rename_note'
  post 'api/change_note_text', to: 'notebook#change_note_text'

  post 'api/create_folder', to: 'notebook#create_folder'
  post 'api/move_folder', to: 'notebook#move_folder'
  post 'api/destroy_folder', to: 'notebook#destroy_folder'
  post 'api/rename_folder', to: 'notebook#rename_folder'
end
