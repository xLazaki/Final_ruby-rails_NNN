json.extract! channel, :id, :channel_name, :about, :user_id, :created_at, :updated_at
json.url channel_url(channel, format: :json)
