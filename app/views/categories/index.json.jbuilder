json.array!(@categories) do |category|
  json.extract! category, :id, :quiz_id, :name
  json.url category_url(category, format: :json)
end
