json.array!(@questions) do |question|
  json.extract! question, :id, :question, :correct_answer, :altone_answer, :alt_two_answer, :altthree_answer, :category_id
  json.url question_url(question, format: :json)
end
