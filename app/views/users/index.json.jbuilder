json.array!(@users) do |user|
  json.extract! user, :id, :last_name, :first_name, :email, :role, :position, :status
  json.url user_url(user, format: :json)
end
