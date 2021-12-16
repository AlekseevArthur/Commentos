json.array!(@comments) do |comment|
  json.comment_id comment.id
  json.text comment.text
  json.author comment.user.email
  json.topic_id comment.topic_id
  json.canDelete(current_user&.admin? || current_user&.email == comment.user.email)
end
