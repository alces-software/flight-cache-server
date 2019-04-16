#==============================================================================
# Copyright (C) 2019-present Alces Flight Ltd.
#
# This file is part of flight-cache-server.
#
# This program and the accompanying materials are made available under
# the terms of the Eclipse Public License 2.0 which is available at
# <https://www.eclipse.org/legal/epl-2.0>, or alternative license
# terms made available by Alces Flight Ltd - please direct inquiries
# about licensing to licensing@alces-flight.com.
#
# This project is distributed in the hope that it will be useful, but
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR
# IMPLIED INCLUDING, WITHOUT LIMITATION, ANY WARRANTIES OR CONDITIONS
# OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A
# PARTICULAR PURPOSE. See the Eclipse Public License 2.0 for more
# details.
#
# You should have received a copy of the Eclipse Public License 2.0
# along with this project. If not, see:
#
#  https://opensource.org/licenses/EPL-2.0
#
# For more information on flight-cache-server, please visit:
# https://github.com/alces-software/flight-cache-server
#===============================================================================

FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "test-group#{n}" }
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    global_admin { false }
    default_group { build(:group) }
    upload_limit { 1048576 }

    factory :admin do
      global_admin { true }
    end
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

  factory :container_base, class: 'Container' do
    tag
    group { nil }
    user { nil }
    admin { false }

    factory :user_container do
      user
    end

    factory :group_container do
      group
    end
  end

  factory :tag do
    sequence(:name) { |n| "autotag#{n}" }
    max_size { 1024 }
  end
end
