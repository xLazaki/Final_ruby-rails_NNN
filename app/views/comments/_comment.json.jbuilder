json.extract! comment, :id, :comment, :user_id, :video_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
