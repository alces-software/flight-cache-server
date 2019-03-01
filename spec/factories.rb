
FactoryBot.define do
  factory :group do
    name { "test-group" }
  end

  factory :user do
    email { "user@example.com" }
    global_admin { false }
    group
  end

  factory :blob do
  end

  factory :container do
    tool_tag
    group
  end

  factory :tool_tag do
    name { "test-cloud-application" }
  end
end
