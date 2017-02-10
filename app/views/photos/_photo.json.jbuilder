json.extract! photo, :id, :image, :caption, :description, :created_at, :updated_at
json.url photo_url(photo, format: :json)