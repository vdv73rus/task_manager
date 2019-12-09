FactoryBot.define do
  factory :task do
    name
    description
    author { create :manager }
  end
end
