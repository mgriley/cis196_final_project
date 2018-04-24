class NotebookController < ApplicationController

  def index
    render template: "notebook/index"
  end

  # Args: None
  def file_tree
    root_folder = Folder.find_by(parent_folder: nil)
    tree = {
      notes: {},
      folders: {},
      root_folder_id: root_folder.id.to_s
    }
    queue = []
    queue << {parent_folder: nil, folder: root_folder}
    while not queue.empty?
      item = queue.shift
      puts "#{item}"
      folder = item[:folder]
      parent_folder = item[:parent_folder]
      json = {}
      json[:id] = folder.id.to_s
      json[:name] = folder.name
      if parent_folder.nil?
        json[:parent_folder_id] = nil
      else
        json[:parent_folder_id] = parent_folder.id.to_s
      end
      json[:notes] = []
      folder.notes.each { |n|
        note_json = {
          id: n.id,
          name: n.name,
          parent_folder_id: folder.id
        }
        tree[:notes][n.id] = note_json
        json[:notes] << n.id.to_s
      }
      json[:folders] = []
      folder.folders.each { |f|
        json[:folders] << f.id.to_s
        queue << {parent_folder: folder, folder: f}
      }
      tree[:folders][folder.id] = json
    end
    # TODO - debug
    puts tree
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
  # new_name
  # new_content
  def update_note
    note = Note.find(params[:note_id])
    note.update(name: params[:new_name], content: params[:new_content])
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
