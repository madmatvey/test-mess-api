json.chat do
  json.id @chat.id
  json.sender do
    json.id @chat.sender.id
    json.nickname @chat.sender.nickname
  end
  json.recipient do
    json.id @chat.recipient.id
    json.nickname @chat.recipient.nickname
  end
  json.messages @chat.messages.each do |message|
    json.body message.body
    json.sender_id message.user_id
    json.created_at l(message.created_at, format: :default)
  end
  json.created_at l(@chat.created_at, format: :default)
end
