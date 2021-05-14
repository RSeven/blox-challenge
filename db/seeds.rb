if !User.exists?(email: "user_1@example.com")
  User.create!(
    email: "user_1@example.com",
    password: "user_1"
  )
end

if !User.exists?(email: "user_2@example.com")
  User.create!(
    email: "user_2@example.com",
    password: "user_2"
  )
end

if !User.exists?(email: "moderator@example.com")
  User.create!(
    email: "moderator@example.com",
    password: "moderator",
    role: :moderator
  )
end