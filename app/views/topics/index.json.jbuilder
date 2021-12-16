json.data do
  json.array!(@topics) do |topic|
    json.id topic.id
    json.text topic.text
    json.name topic.name
  end
end
json.haveRights current_user&.admin?
