json.extract! video, :id, :title, :description, :tag, :created_at, :updated_at
json.url video_url(video, format: :json)
