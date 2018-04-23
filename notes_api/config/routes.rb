Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # serve the website
  root 'notebook#index'

  # REST API

  get 'file_tree', to: 'notebook#file_tree'
  get 'note', to: 'notebook#note'

  post 'create_note', to: 'notebook#create_note'
  post 'move_note', to: 'notebook#move_note'
  post 'destroy_note', to: 'notebook#destroy_note'
  post 'rename_note', to: 'notebook#rename_note'
  post 'change_note_text', to: 'notebook#change_note_text'

  post 'create_folder', to: 'notebook#create_folder'
  post 'move_folder', to: 'notebook#move_folder'
  post 'destroy_folder', to: 'notebook#destroy_folder'
  post 'rename_folder', to: 'notebook#rename_folder'
end
