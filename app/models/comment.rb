class Comment < ApplicationRecord
#No validation and allows stored XSS

  belongs_to :user
  belongs_to :post
end
