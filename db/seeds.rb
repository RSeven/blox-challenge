if !User.exists?(email: "user1@example.com")
  User.create!(
    email: "user1@example.com",
    name: "user1",
    password: "user1"
  )
end

if !User.exists?(email: "user2@example.com")
  User.create!(
    email: "user2@example.com",
    name: "user2",
    password: "user2"
  )
end

if !User.exists?(email: "moderator@example.com")
  User.create!(
    email: "moderator@example.com",
    name: "moderator",
    password: "moderator"
  )
end