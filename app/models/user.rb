class User < ApplicationRecord
#Password is stored in plain text
#No validations at all
#No sanitization or input checks

  has_many :posts
  has_many :comments

#Intentional SQL Injection vulnerability in authentication
  def self.authenticate(email, password)
    User.find_by_sql("SELECT * FROM users WHERE email='#{email}' AND password='#{password}'").first
  end
end

