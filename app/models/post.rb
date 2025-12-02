class Post < ApplicationRecord
#No validations and allows XSS payloads 

belongs_to :user
has_many :coments
  
end
