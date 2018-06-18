json.chats @chats.each do |chat|
  json.id chat.id
  json.sender chat.sender
  json.recipient chat.recipient
  json.created_at l(chat.created_at, format: :default)
end

json.users @users.each do |user|
  json.id user.id
  json.nickname user.nickname
end

json.current_user do
  json.id @current_user.id
  json.nickname @current_user.nickname
end
