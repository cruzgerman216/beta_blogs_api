FactoryBot.define do
  factory :monthly_summary do
    user { nil }
    month { "2024-03-13" }
    total_likes { 1 }
  end
end
