RSpec.describe Ability, type: :ability do
  subject { Ability.new(user) }

  describe 'with a global admin' do
    let(:user) { create(:user, global_admin: true) }

    it { is_expected.to be_can(:manage, :all) }
    it { is_expected.to be_can(:access, :rails_admin) }
    it { is_expected.to be_can(:read, :dashboard) }
  end

  describe 'without a user' do
    let(:user) { nil }

    it { is_expected.not_to be_can(:access, :rails_admin) }
    it { is_expected.not_to be_can(:manage, :all) }
  end

  describe 'with a regular user' do
    let(:user) { create(:user) }

    it { is_expected.not_to be_can(:access, :rails_admin) }

    context 'when it shares a group with the container' do
      let!(:container) { create(:container, group: user.group) }

      it { is_expected.to be_can(:read, container) }
    end

    context 'when it does not share a group' do
      let(:other_group) { create(:group, name: "not-#{user.group.name}") }
      let(:container) { create(:container, group: other_group) }

      it { is_expected.not_to be_can(:read, container) }
    end
  end
end
