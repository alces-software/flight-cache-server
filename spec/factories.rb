
FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "test-group#{n}" }
  end

  factory :user do
    email { "user@example.com" }
    global_admin { false }
    default_group { build(:group) }
  end

  factory :blob do
    container
    active_storage_blob
  end

  factory :active_storage_blob, class: 'ActiveStorage::Blob' do
    filename { 'test-file-name' }
    byte_size { 0 }
    checksum { '00000000000' }
    key { SecureRandom.hex(10) }
  end

  factory :container do
    tag
    group
  end

  factory :tag do
    name { "test-cloud-application" }
  end
end
