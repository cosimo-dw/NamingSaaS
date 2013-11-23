json.array!(@messages) do |message|
  json.extract! message, :content
  json.url message_url(message, format: :json)
end