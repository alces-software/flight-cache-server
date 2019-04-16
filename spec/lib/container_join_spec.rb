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
require 'container_join'
require 'stringio'
require 'scope_parser'

RSpec.describe ContainerJoin do
  subject { described_class.new(entity) }

  context 'with a regular user entity' do
    let(:entity) { user }
    let(:user) { create(:user) }
    let(:group) { create(:group) }

    let!(:group_container) { create(:container_base, group: group) }
    let!(:user_container) { create(:container_base, user: user) }
    let!(:user_admin_container) {
      create(:container_base, user: user, admin: true)
    }
    let!(:global_container) { create(:container_base, group: ScopeParser.global_group) }

    describe '#owns.containers' do
      it 'returns the containers it directly owns' do
        expect(subject.owns.containers).to contain_exactly(
          user_container, user_admin_container
        )
      end
    end
  end
end
