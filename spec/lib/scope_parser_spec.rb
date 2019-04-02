require 'rails_helper'
require 'scope_parser'

RSpec.describe ScopeParser do
  subject { described_class.new(current_user) }

  context 'when the current_user is a regular user' do
    let(:current_user) { build(:user) }

    describe '#parse' do
      it 'returns nil for nil' do
        expect(subject.parse(nil)).to eq(nil)
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

      context 'when parsing the :global scope' do
        it 'returns a group' do
          expect(subject.parse(:global)).to be_a(Group)
        end

        it 'is named global' do
          expect(subject.parse(:global).name).to eq('global')
        end
      end
    end
  end
end
