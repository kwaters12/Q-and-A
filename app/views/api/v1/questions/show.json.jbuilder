json.(@question, :topic, :body, :id)

json.answers @question.answers do |answer|
  json.body answer.body
end