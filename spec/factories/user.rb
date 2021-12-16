FactoryBot.define do
  factory :user do
    email                 { 'qwerty@qwerty' }
    password              { '111111' }
    password_confirmation { '111111' }
  end

  factory :admin, parent: :user do
    email { 'admin@admin' }
    admin { true }
  end

  factory :tony_hawk, parent: :user do
    email { 'tony@hawk' }
  end
end
