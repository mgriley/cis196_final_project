class Folder < ApplicationRecord
  # only the root folder has no parent folder
  belongs_to :parent_folder, class_name: "Folder", foreign_key: :parent_folder_id, optional: true
  has_many :folders, class_name: "Folder", foreign_key: :parent_folder_id, dependent: :destroy
  has_many :notes, class_name: "Note", foreign_key: :folder_id, dependent: :destroy
  validates :name, presence: true
end
