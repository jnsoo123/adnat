FactoryBot.define do
  factory :shift do
    user
    start { "2019-07-08 08:02:58" }
    finish { "2019-07-08 17:02:58" }
    break_length { 60 }
  end
end
