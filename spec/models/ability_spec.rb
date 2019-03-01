RSpec.describe Ability, type: :ability do
  subject { Ability.new(user) }

  describe 'with a user' do
    let(:user) { create(:user) }
    it { is_expected.to be_can(:manage, Container) }
    it { is_expected.to be_can(:manage, Blob) }
  end

  describe 'without a user' do
    let(:user) { nil }

    it { is_expected.not_to be_can(:manage, Container) }
    it { is_expected.not_to be_can(:manage, Blob) }
  end
end
