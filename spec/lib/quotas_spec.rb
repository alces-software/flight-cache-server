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

require 'rails_helper'
require 'quotas'
require 'stringio'

RSpec.describe Quotas do
  let(:payload) { 'a' * size }
  let(:io) { StringIO.new(payload) }

  subject { described_class.new(io, container) }

  context 'with an empty file' do
    let(:container) { build(:container) }
    let(:size) { 0 }

    describe '#enforce_tag_limit' do
      it 'passes' do
        expect do
          subject.enforce_tag_limit
        end.not_to raise_error
      end
    end
  end

  context 'when the file size exceeds the container limit' do
    let(:container) { build(:container) }
    let(:size) { container.tag.max_size + 1 }

    describe '#enforce_tag_limit' do
      it 'errors' do
        expect do
          subject.enforce_tag_limit
        end.to raise_error(UploadTooLarge)
      end
    end
  end
end
