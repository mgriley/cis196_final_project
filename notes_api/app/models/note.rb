class Note < ApplicationRecord
  belongs_to :folder, class_name: "Folder", foreign_key: :folder_id
  validates :name, presence: true
end
