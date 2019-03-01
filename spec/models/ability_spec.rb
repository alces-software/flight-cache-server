RSpec.describe Ability, type: :ability do
  subject { Ability.new(user) }

  describe 'with a global admin' do
    let(:user) { create(:user, global_admin: true) }

    it { is_expected.to be_can(:manage, :all) }
  end

  describe 'without a user' do
    let(:user) { nil }

    it { is_expected.not_to be_can(:manage, :all) }
  end
end
