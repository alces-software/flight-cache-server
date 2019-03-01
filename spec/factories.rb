
FactoryBot.define do
  factory :user do
    email { "user@example.com" }
    global_admin { false }
  end

  factory :blob do
  end

  factory :container do
    tool_tag
  end

  factory :tool_tag do
    name { "test-cloud-application" }
  end
end
