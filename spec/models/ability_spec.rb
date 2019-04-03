RSpec.describe Ability, type: :ability do
  shared_context 'with container blobs' do
    let!(:blobs) do
      10.times { create(:blob, container: container) }
    end
  end

  shared_examples 'full blobs access' do
    it { is_expected.to be_can(:manage, Blob) }
  end

  subject { Ability.new(user) }

  describe 'with a global admin' do
    include_context 'with container blobs'

    let(:container) { create(:container) }
    let(:user) { create(:user, global_admin: true) }

    it { is_expected.to be_can(:manage, :all) }
    it { is_expected.to be_can(:access, :rails_admin) }
    it { is_expected.to be_can(:read, :dashboard) }
    it { is_expected.to be_can(:download, container.blobs.first) }
    it { is_expected.to be_can(:upload, Container) }
  end

  describe 'without a user' do
    include_context 'with container blobs'

    let(:container) { create(:container) }
    let(:user) { nil }

    it { is_expected.not_to be_can(:access, :rails_admin) }
    it { is_expected.not_to be_can(:manage, :all) }
    it { is_expected.not_to be_can(:download, container.blobs.first) }
    it { is_expected.not_to be_can(:upload, container) }
  end

  describe 'with a regular user' do
    let(:user) { create(:user) }

    it { is_expected.not_to be_can(:access, :rails_admin) }

    context 'when it shares a group with the container' do
      include_context 'with container blobs'

      let(:container) { create(:container, group: user.default_group) }

      it { is_expected.to be_can(:show, container) }
      it { is_expected.to be_can(:show, container.blobs.first) }
      it { is_expected.to be_can(:download, container.blobs.first) }
      it { is_expected.to be_can(:upload, container) }
    end

    context 'when it does not share a group' do
      include_context 'with container blobs'

      let(:other_group) { create(:group, name: "not-#{user.default_group.name}") }
      let(:container) { create(:container, group: other_group) }

      it { is_expected.not_to be_can(:show, container) }
      it { is_expected.not_to be_can(:show, container.blobs.first) }
      it { is_expected.not_to be_can(:download, container.blobs.first) }
      it { is_expected.not_to be_can(:upload, container) }
    end
  end
end
