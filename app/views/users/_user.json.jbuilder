json.extract! user, :id, :nickname, :balance, :created_at, :updated_at
json.url user_url(user, format: :json)
