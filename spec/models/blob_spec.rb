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
# For more information on flight-account, please visit:
# https://github.com/alces-software/flight-cache-server
#===============================================================================

require 'rails_helper'

RSpec.describe Blob, type: :model do
  describe '::upload_and_create!' do
    shared_examples 'raises UploadTooLarge' do
      it 'errors' do
        expect do
          described_class.upload_and_create!(
            io: io, filename: 'test', container: container
          )
        end.to raise_error(UploadTooLarge)
      end
    end

    let(:io) { StringIO.new(payload) }

    context 'when the file size exceeds the max size' do
      let(:container) { build(:container) }
      let(:payload) { 'a' * (container.max_size + 1) }

      include_examples 'raises UploadTooLarge'
    end

    context 'when exceeding a user upload limit' do
      let(:user) { create(:user, upload_limit: 5) }
      let(:container) { create(:container, group: nil, user: user) }
      let(:payload) { 'a' * (user.remaining_limit + 1) }

      include_examples 'raises UploadTooLarge'
    end
  end
end
