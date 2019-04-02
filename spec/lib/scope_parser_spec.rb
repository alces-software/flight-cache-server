require 'rails_helper'
require 'scope_parser'

RSpec.describe ScopeParser do
  subject { described_class.new(current_user) }

  context 'when the current_user is a regular user' do
    let(:current_user) { build(:user) }

    describe '#parse' do
      it 'returns the user model for :user' do
        expect(subject.parse(:user)).to eq(current_user)
      end
    end
  end
end
