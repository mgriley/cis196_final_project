class NotebookController < ApplicationController

  def index
    render template: "notebook/index"
  end

  def folder_to_json(folder)
    parent_folder_id = 
      folder.parent_folder.nil? ? nil : folder.parent_folder.id.to_s
    json = {
      id: folder.id.to_s,
      name: folder.name,
      parent_folder_id: parent_folder_id,
      notes: folder.notes.map { |n| n.id.to_s },
      folders: folder.folders.map { |f| f.id.to_s }
    }
  end

  def note_to_json(note)
    {
      id: note.id.to_s,
      name: note.name,
      content: note.content,
      parent_folder_id: note.folder.id.to_s
    }
  end

  # Args: None
  # Return: file tree as json object
  def file_tree
    root_folder = Folder.find_by(parent_folder: nil)
    tree = {
      notes: {},
      folders: {},
      root_folder_id: root_folder.id.to_s
    }
    Note.all.each { |note|
      tree[:notes][note.id] = note_to_json(note)    
    }
    Folder.all.each { |folder|
      tree[:folders][folder.id] = folder_to_json(folder)
    }
    render json: tree
  end

  # Args:
  # note_id
  # Reply: note
  def note
    note = Note.find(params[:note_id])
    render json: note_to_json(note)
  end

  # Args:
  # folder_id
  # Reply: the newly created note
  def create_note
    folder = Folder.find(params[:folder_id])
    note_params = {
      name: 'untitled',
      content: ''
    }
    note = folder.notes.create!(note_params)
    render json: note_to_json(note)
  end

  # Args:
  # note_id
  # new_parent_folder_id
  # Reply: the note (with modified parent folder)
  def move_note
    note = Note.find(params[:note_id])
    new_folder = Folder.find(params[:new_parent_folder_id])
    new_folder.notes << note
    render json: note_to_json(note)
  end

  # Args:
  # note_id
  # Reply: empty
  def destroy_note
    note = Note.find(params[:note_id])
    note.destroy
    render json: {}
  end

  # Args:
  # note_id
  # new_name
  # Reply: the renamed note
  def rename_note
    note = Note.find(params[:note_id])
    note.update(name: params[:new_name])
    render json: note_to_json(note)
  end

  # Args:
  # note_id
  # new_name
  # new_content
  # Reply: the updated note
  def update_note
    note = Note.find(params[:note_id])
    note.update(name: params[:new_name], content: params[:new_content])
    render json: note_to_json(note)
  end

  # Args:
  # parent_folder_id
  # name
  # Reply: the created folder
  def create_folder
    parent_folder = Folder.find(params[:parent_folder_id])
    folder_params = {
      name: params[:name]
    }
    folder = parent_folder.folders.create!(folder_params)
    render json: folder_to_json(folder)
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
  # Reply: the moved folder
  def move_folder
    folder = Folder.find(params[:folder_id])
    new_parent_folder = Folder.find(params[:new_parent_folder_id])
    if (folder.id == new_parent_folder.id) || is_subfolder(folder, new_parent_folder)
      puts "cannot move a folder to one of its subfolders!"
      raise Exception.new('cannot move a folder to itself or one of its subfolders')
    else
      new_parent_folder.folders << folder
      render json: folder_to_json(folder)
    end
  end

  # Args:
  # folder_id
  # Reply: empty
  def destroy_folder
    folder = Folder.find(params[:folder_id])
    folder.destroy
    render json: {}
  end

  # Args:
  # folder_id
  # new_name
  # Reply: the renamed folder
  def rename_folder
    folder = Folder.find(params[:folder_id])
    folder.update(name: params[:new_name])
    render json: folder_to_json(folder)
  end

end
