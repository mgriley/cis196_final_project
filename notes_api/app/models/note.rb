class Note < ApplicationRecord
  belongs_to :folder, class_name: "Folder"
end
