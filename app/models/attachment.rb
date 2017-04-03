class Attachment < ApplicationRecord
  belongs_to :user
  validates :url, format: { with: /.pdf/,
    message: "only allow pdfs" }
end
