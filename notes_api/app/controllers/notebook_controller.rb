class NotebookController < ApplicationController

  def index
    render template: "notebook/index"
  end

  # Args: None
  def file_tree
    tree = {}
    queue = []
    root_folder = Folder.find_by(parent_folder: nil)
    queue << {json: tree, folder: root_folder}
    while not queue.empty?
      item = queue.shift
      puts "#{item}"
      json = item[:json]
      folder = item[:folder]
      json[:id] = folder.id
      json[:name] = folder.name
      json[:notes] = []
      folder.notes.each { |n|
        json[:notes] << {id: n.id, name: n.name}
      }
      json[:folders] = []
      folder.folders.each { |f|
        subfolder_json = {}
        json[:folders] << subfolder_json
        queue << {json: subfolder_json, folder: f}
      }
    end
    render json: tree
  end

  # Args:
  # note_id
  def note
    note = Note.find(params[:note_id])
    render json: note
  end

  # Args:
  # folder_id
  def create_note
    folder = Folder.find(params[:folder_id])
    note_params = {
      name: 'untitled',
      content: 'write here'
    }
    folder.notes.create!(note_params)
  end

  # Args:
  # note_id
  # new_parent_folder_id
  def move_note
    note = Note.find(params[:note_id])
    new_folder = Folder.find(params[:new_parent_folder_id])
    new_folder.notes << note
  end

  # Args:
  # note_id
  def destroy_note
    note = Note.find(params[:note_id])
    note.destroy
  end

  # Args:
  # note_id
  # new_name
  def rename_note
    note = Note.find(params[:note_id])
    note.update(name: params[:new_name])
  end

  # Args:
  # note_id
  # new_text
  def change_note_text
    note = Note.find(params[:note_id])
    note.update(content: params[:new_text])
  end

  # Args:
  # parent_folder_id
  # name
  def create_folder
    parent_folder = Folder.find(params[:parent_folder_id])
    folder_params = {
      name: params[:name]
    }
    parent_folder.folders.create!(folder_params)
  end

  def is_subfolder(parent_folder, folder)
    parent = folder.parent_folder
    while not parent.nil?
      if parent.id == parent_folder.id
        return true
      end
      parent = parent.parent_folder
    end
    return false
  end

  # Args:
  # folder_id
  # new_parent_folder_id
  def move_folder
    folder = Folder.find(params[:folder_id])
    new_parent_folder = Folder.find(params[:new_parent_folder_id])
    if (folder.id == new_parent_folder.id) || is_subfolder(folder, new_parent_folder)
      # TODO: return error
      puts "cannot move a folder to one of its subfolders!"
    else
      new_parent_folder.folders << folder
    end
  end

  # Args:
  # folder_id
  def destroy_folder
    folder = Folder.find(params[:folder_id])
    folder.destroy
  end

  # Args:
  # folder_id
  # new_name
  def rename_folder
    folder = Folder.find(params[:folder_id])
    folder.update(name: params[:new_name])
  end

end
