class Note < ApplicationRecord
  belongs_to :folder, class_name: "Folder"
  validates :name, presence: true
end
