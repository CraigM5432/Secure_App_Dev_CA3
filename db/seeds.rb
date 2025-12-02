#Creating Users
User.create(
  email: "admin@example.com",
  password: "admin123",      # password displayed in plain text
  display_name: "AdminUser",
  role: "admin"
)

User.create(
  email: "john@example.com",
  password: "password123",   # password displayed in plain text
  display_name: "John",
  role: "user"
)

User.create(
  email: "attacker@example.com",
  password: "<script>alert('XSS')</script>", # password with stored XSS
  display_name: "<h1>XSS</h1>",
  role: "user"
)

#User PPosts
Post.create(
  user_id: 1,
  title: "Welcome to the Insecure Blog",
  body: "<script>alert('XSS!');</script> test post."
)

Post.create(
  user_id: 2,
  title: "User John’s Post",
  body: "Posting generic infomrmation about myself."
)

#User comments
Comment.create(
  user_id: 3,
  post_id: 1,
  body: "<img src=x onerror=alert('XSS!')>"
)

Comment.create(
  user_id: 2,
  post_id: 1,
  body: "Nice post!"
)

