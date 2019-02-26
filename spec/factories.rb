
FactoryBot.define do
  factory :blob do
    
  end

  factory :container do
    bucket { 'test-bucket' }
    tool_tag
  end

  factory :tool_tag do
    name { "test-cloud-application" }
  end
end
