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
require 'scope_parser'

RSpec.describe ScopeParser do
  subject { described_class.new(current_user) }
  let(:other_user) { create(:user, email: 'other-user@example.com') }
  let(:other_group) { create(:group, name: 'other-group-name') }

  describe '#parse' do
    context 'when the current_user is a regular user' do
      let(:current_user) { build(:user) }

      it 'returns nil for nil' do
        expect(subject.parse(nil)).to eq(nil)
      end

      it 'returns nil for empty string' do
        expect(subject.parse('')).to eq(nil)
      end

      it 'returns the user model for :user' do
        expect(subject.parse(:user)).to eq(current_user)
      end

      it "returns the user's group for :group" do
        expect(subject.parse(:group)).to eq(current_user.default_group)
      end

      it 'returns the current_user when email matches' do
        expect(subject.parse(current_user.email)).to eq(current_user)
      end

      it 'returns the group when the name matches' do
        group = current_user.default_group
        expect(subject.parse(group.name)).to eq(group)
      end

      it 'can not parse the other user' do
        expect do
          subject.parse(other_user.email)
        end.to raise_error(InvalidScope)
      end

      it 'can not parse the other group' do
        expect do
          subject.parse(other_group.name)
        end.to raise_error(InvalidScope)
      end

      context 'when parsing the :global scope' do
        it 'returns a group' do
          expect(subject.parse(:global)).to be_a(Group)
        end

        it 'is named global' do
          expect(subject.parse(:global).name).to eq('global')
        end
      end
    end

    context 'when the current user is an admin' do
      let(:current_user) { build(:user, global_admin: true) }

      it 'can parse other users by email' do
        expect(subject.parse(other_user.email)).to eq(other_user)
      end

      it 'can parse other groups by name' do
        expect(subject.parse(other_group.name)).to eq(other_group)
      end
    end
  end
end
