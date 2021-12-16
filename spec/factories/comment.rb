FactoryBot.define do
  factory :comment do
    user
    topic
    text { 'textg comment' }
  end

  factory :comment_from_admin, parent: :comment do
    user { association :admin }
    topic
    text { 'comment from admin' }
  end

  factory :comment_from_tony_hawk, parent: :comment do
    user { association :tony_hawk }
    topic
    text { 'comment from tony hawk!' }
  end
end
