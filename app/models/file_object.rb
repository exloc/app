class FileObject < ApplicationRecord
  belongs_to :code_example

  validates :code_example, presence: true
  validates :name, presence: true
  validates :size, numericality: { greater_than_or_equal_to: 0 }
  validates :file_type, inclusion: { in: %w(file dir) }
  validates :url,
    format: { with: URI::regexp(%w(http https)) },
    allow_nil: true
end
